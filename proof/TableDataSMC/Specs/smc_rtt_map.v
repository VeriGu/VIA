Require Import SpecDeps.
Require Import RData.
Require Import EventReplay.
Require Import MoverTypes.
Require Import Constants.
Require Import CommonLib.
Require Import TableAux.Spec.
Require Import AbsAccessor.Spec.
Require Import TableDataOpsIntro.Spec.
Require Import TableDataOpsRef3.Spec.

Local Open Scope Z_scope.

Section Spec.

  Definition map_table (llt_gidx: Z) (idx: Z) (level: Z) (adt: RData) :=
    let gn_llt := (gs (share adt)) @ llt_gidx in
    rely (g_tag (ginfo gn_llt) =? GRANULE_STATE_TABLE);
    rely (gtype gn_llt =? GRANULE_STATE_TABLE);
    let llt_pte := (g_data (gnorm gn_llt)) @ idx in
    rely is_int64 llt_pte;
    if (level <? RTT_PAGE_LEVEL) && (__entry_is_table llt_pte) then
      Some (adt {log: EVT CPU_ID (REL llt_gidx gn_llt {glock: Some CPU_ID}) :: log adt}, VZ64 1)
    else
      let data_addr := PTE_TO_PA llt_pte in
      let ipa_state := PTE_TO_IPA_STATE llt_pte in
      if ipa_state =? IPA_STATE_ABSENT then
        let new_pgte := Z.lor (Z.lor (IPA_STATE_TO_PTE IPA_STATE_PRESENT) data_addr)
                              (if level =? RTT_PAGE_LEVEL then PGTE_S2_PAGE else PGTE_S2_BLOCK) in

        let llt' := (g_data (gnorm gn_llt)) # idx == new_pgte in
        let gllt' := gn_llt {gnorm: (gnorm gn_llt) {g_data: llt'}} in
        Some (adt {log: EVT CPU_ID (REL llt_gidx gllt' {glock: Some CPU_ID}) :: log adt}
                  {share : (share adt) {gs : (gs (share adt)) # llt_gidx == gllt'}}, VZ64 0)
      else
        Some (adt {log: EVT CPU_ID (REL llt_gidx gn_llt {glock: Some CPU_ID}) :: log adt}, VZ64 1).

  Definition smc_rtt_map_spec (rd_addr: Z64) (map_addr: Z64) (level: Z64) (adt: RData) : option (RData * Z64) :=
    match rd_addr, map_addr, level with
    | VZ64 rd_addr, VZ64 map_addr, VZ64 level =>
      rely is_int64 rd_addr; rely is_int64 map_addr;
      if (level >=? 2) && (level <=? 3) && __addr_is_level_aligned map_addr 3 then
        rely GRANULE_ALIGNED rd_addr; rely GRANULE_ALIGNED map_addr;
        let rd_gidx := __addr_to_gidx rd_addr in
        rely is_gidx rd_gidx;
        when adt == query_oracle adt;
        let grd := (gs (share adt)) @ rd_gidx in
        rely prop_dec (glock grd = None);
        rely (g_tag (ginfo grd) =? GRANULE_STATE_RD);
        rely (gtype grd =? GRANULE_STATE_RD);
        let erd' := EVT CPU_ID (REL rd_gidx (grd {glock: Some CPU_ID})) in
        let adt := adt {log: EVT CPU_ID (ACQ rd_gidx) :: log adt} in
        let idx0 := __addr_to_idx map_addr 0 in
        let idx1 := __addr_to_idx map_addr 1 in
        let idx2 := __addr_to_idx map_addr 2 in
        let idx3 := __addr_to_idx map_addr 3 in
        let ret_idx := (if level =? 1 then idx0 else if level =? 2 then idx1 else if level =? 3 then idx2 else idx3) in
        rely prop_dec ((buffer (priv adt)) @ SLOT_RD = None);
        rely prop_dec ((buffer (priv adt)) @ SLOT_TABLE = None);
        let root_gidx := (g_rtt (gnorm grd)) in
        rely is_gidx rd_gidx; rely is_gidx root_gidx;
        (* hold root lock *)
        let groot := (gs (share adt)) @ root_gidx in
        rely (tbl_level (gaux groot) =? 0);
        rely prop_dec (glock groot = None);
        rely (g_tag (ginfo groot) =? GRANULE_STATE_TABLE);
        rely (gtype groot =? GRANULE_STATE_TABLE);
        (* walk deeper root *)
        let entry0 := (g_data (gnorm groot)) @ idx0 in
        rely is_int64 entry0;
        let phys0 := __entry_to_phys entry0 3 in
        let lv1_gidx := __addr_to_gidx phys0 in
        rely (__entry_is_table entry0) && (GRANULE_ALIGNED phys0) && (is_gidx lv1_gidx);
        (* level 1 valid, hold level 1 lock *)
        let glv1 := (gs (share adt)) @ lv1_gidx in
        rely prop_dec (glock glv1 = None);
        rely (tbl_level (gaux glv1) =? 1);
        (* walk deeper level 1 *)
        rely (g_tag (ginfo glv1) =? GRANULE_STATE_TABLE);
        rely (gtype glv1 =? GRANULE_STATE_TABLE);
        let entry1 := (g_data (gnorm glv1)) @ idx1 in
        rely is_int64 entry1;
        let phys1 := __entry_to_phys entry1 3 in
        let lv2_gidx := __addr_to_gidx phys1 in
        rely (__entry_is_table entry1) && (GRANULE_ALIGNED phys1) && (is_gidx lv2_gidx);
        (* level 2 valid, hold level 2 lock *)
        let glv2 := (gs (share adt)) @ lv2_gidx in
        rely (tbl_level (gaux glv2) =? 2);
        rely prop_dec (glock glv2 = None);
        if level =? 3 then
          (* walk until level 2 *)
          let adt := adt {log: EVT CPU_ID (RTT_WALK root_gidx map_addr 2) :: log adt} in
          let adt :=  adt {priv: (priv adt) {wi_llt: lv2_gidx} {wi_index: idx2}} in
          map_table lv2_gidx idx2 level adt
        else
          (* walk deeper level 2 *)
          rely (g_tag (ginfo glv2) =? GRANULE_STATE_TABLE);
          rely (gtype glv2 =? GRANULE_STATE_TABLE);
          let entry2 := (g_data (gnorm glv2)) @ idx2 in
          rely is_int64 entry2;
          let phys2 := __entry_to_phys entry2 3 in
          let lv3_gidx := __addr_to_gidx phys2 in
          rely (__entry_is_table entry2) && (GRANULE_ALIGNED phys2) && (is_gidx lv3_gidx);
          (* level 2 valid, hold level 2 lock *)
          let glv3 := (gs (share adt)) @ lv3_gidx in
          rely prop_dec (glock glv3 = None);
          rely (tbl_level (gaux glv3) =? 3);
          if level =? 4 then
            (* walk until level 3 *)
            let adt := adt {log: EVT CPU_ID (RTT_WALK root_gidx map_addr 3) :: log adt} in
            let adt :=  adt {priv: (priv adt) {wi_llt: lv3_gidx} {wi_index: idx3}} in
            map_table lv3_gidx idx3 level adt
          else (* can't be other level *)
            None
      else Some (adt, VZ64 0)
    end.

End Spec.


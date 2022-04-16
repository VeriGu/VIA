Require Import SpecDeps.
Require Import RData.
Require Import EventReplay.
Require Import MoverTypes.
Require Import Constants.
Require Import CommonLib.
Require Import AbsAccessor.Spec.
Require Import PendingCheckAux.Spec.
Require Import RVIC4.Spec.

Local Open Scope Z_scope.

Section SpecLow.

  Definition check_pending_ptimers_spec0 (rec: Pointer) (adt: RData) : option RData :=
    match rec with
    | (_rec_base, _rec_ofst) =>
      when'' _g_rec_base, _g_rec_ofst == get_rec_g_rec_spec (_rec_base, _rec_ofst) adt;
      rely is_int _g_rec_ofst;
      when' _cntp_ctl == sysreg_read_spec 32 adt;
      rely is_int64 _cntp_ctl;
      when'' _t'6_base, _t'6_ofst == get_rec_ptimer_spec (_rec_base, _rec_ofst) adt;
      rely is_int _t'6_ofst;
      when _t'7, adt == check_timer_became_asserted_spec (_t'6_base, _t'6_ofst) (VZ64 _cntp_ctl) adt;
      rely is_int _t'7;
      if (_t'7 =? 1) then
        when adt == granule_lock_spec (_g_rec_base, _g_rec_ofst) adt;
        rely is_int64 (Z.lor _cntp_ctl 2);
        let _cntp_ctl := (Z.lor _cntp_ctl 2) in
        when adt == sysreg_write_spec 32 (VZ64 _cntp_ctl) adt;
        when' _t'3 == get_rec_sysregs_spec (_rec_base, _rec_ofst) 69 adt;
        rely is_int64 _t'3;
        rely is_int64 (Z.land _t'3 18446744073709549567);
        when adt == set_rec_sysregs_spec (_rec_base, _rec_ofst) 69 (VZ64 (Z.land _t'3 18446744073709549567)) adt;
        when' _t'4 == get_rec_sysregs_spec (_rec_base, _rec_ofst) 69 adt;
        rely is_int64 _t'4;
        when adt == sysreg_write_spec 69 (VZ64 _t'4) adt;
        when adt == set_rec_ptimer_asserted_spec (_rec_base, _rec_ofst) 1 adt;
        when'' _t'5_base, _t'5_ofst == get_rec_rvic_spec (_rec_base, _rec_ofst) adt;
        rely is_int _t'5_ofst;
        when adt == rvic_set_pending_spec (_t'5_base, _t'5_ofst) (VZ64 30) adt;
        when adt == granule_unlock_spec (_g_rec_base, _g_rec_ofst) adt;
        Some adt
      else
        Some adt
     end
    .

End SpecLow.

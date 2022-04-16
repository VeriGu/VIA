Require Import RefProofDeps.
Require Import RData.
Require Import EventReplay.
Require Import MoverTypes.
Require Import Constants.
Require Import CommonLib.
Require Import RefTactics.
Require Import TableDataOpsIntro.Spec.
Require Import TableDataOpsRef2.Spec.
Require Import TableDataOpsRef3.Specs.data_destroy3.
Require Import TableDataOpsRef3.LowSpecs.data_destroy3.
Require Import TableDataOpsRef3.RefProof.RefRel.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.shiftl Z.shiftr Z.land Z.lor.

Section Refine.

  Hint Unfold
       data_destroy_spec
       data_destroy2_spec
    .

  Lemma data_destroy3_spec_exists:
    forall habd habd'  labd g_rd map_addr res
      (Hspec: data_destroy3_spec g_rd map_addr habd = Some (habd', res))
      (Hrel: relate_RData habd labd),
    exists labd', data_destroy3_spec0 g_rd map_addr labd = Some (labd', res) /\ relate_RData habd' labd'.
  Proof.
    Local Opaque peq ptr_eq.
    intros. duplicate Hrel. destruct D. clear hrepl lrepl. destruct g_rd.
    unfold data_destroy3_spec, data_destroy3_spec0 in *.
    unfold Assertion in *. rm_bind Hspec; rm_bind'. simpl in *.
    unfold Assertion; rm_bind'; grewrite.
    repeat simpl_hyp Hspec; extract_prop_dec; simpl_query_oracle; rm_bind'; grewrite.
    - repeat destruct_con.
      match type of Hcond6 with
      | is_gidx ?gidx = true => remember gidx as lv1_gidx eqn:Hlv1_gidx; symmetry in Hlv1_gidx
      end.
      match type of Hcond3 with
      | is_gidx ?gidx = true => remember gidx as lv2_gidx eqn:Hlv2_gidx; symmetry in Hlv2_gidx
      end.
      match type of Hcond0 with
      | is_gidx ?gidx = true => remember gidx as llt_gidx eqn:Hllt_gidx; symmetry in Hllt_gidx
      end.
      match type of Prop0 with
      | glock ?a @ ?gidx = None => remember gidx as data_gidx eqn:Hdata_gidx; symmetry in Hdata_gidx
      end.
      rewrite_oracle_rel rel_oracle C2; simpl in *.
      repeat (grewrite; simpl).
      assert(Hwalk: repl habd (oracle habd
                                      (EVT CPU_ID (RTT_WALK (g_rtt (gnorm (gs (share habd)) @ z)) z0 3) :: oracle habd (log habd) ++ log habd))
                         s {gs : (gs s) # llt_gidx == (((gs s) @ llt_gidx) {glock : Some CPU_ID})} =
                    Some (s {gs : (gs s) # llt_gidx == (((gs s) @ llt_gidx) {glock : Some CPU_ID})})).
      destruct Hrel. grewrite. destruct valid_ho0. rewrite Hright_log_nil. reflexivity.
      eapply RightLogMover.
      apply walk_right. omega. omega. apply RightLogOracle. simpl.
      rewrite_oracle_rel rel_oracle Hwalk; simpl in *.
      repeat (grewrite; try simpl_htarget; simpl).
      inversion Hspec. eexists; split. reflexivity.
      constructor; destruct Hrel; simpl; try assumption; try reflexivity.
      rewrite <- Prop4. simpl_field.
      assert(data_gidx <> llt_gidx). red; intro T; rewrite T in *. bool_rel. autounfold in *. omega.
      repeat rewrite (zmap_comm _ _ H). repeat (try simpl_htarget; repeat simpl_field; repeat swap_fields).
      reflexivity.
    - repeat destruct_con.
      match type of Hcond6 with
      | is_gidx ?gidx = true => remember gidx as lv1_gidx eqn:Hlv1_gidx; symmetry in Hlv1_gidx
      end.
      match type of Hcond3 with
      | is_gidx ?gidx = true => remember gidx as lv2_gidx eqn:Hlv2_gidx; symmetry in Hlv2_gidx
      end.
      match type of Hcond0 with
      | is_gidx ?gidx = true => remember gidx as llt_gidx eqn:Hllt_gidx; symmetry in Hllt_gidx
      end.
      match type of Prop0 with
      | glock ?a @ ?gidx = None => remember gidx as data_gidx eqn:Hdata_gidx; symmetry in Hdata_gidx
      end.
      rewrite_oracle_rel rel_oracle C2; simpl in *.
      repeat (grewrite; simpl). simpl_htarget.
      inversion Hspec. eexists; split. reflexivity.
      constructor; destruct Hrel; simpl; try assumption; try reflexivity. simpl_htarget. reflexivity.
    - repeat destruct_con.
      match type of Hcond3 with
      | is_gidx ?gidx = true => remember gidx as lv2_gidx eqn:Hlv2_gidx; symmetry in Hlv2_gidx
      end.
      match type of Hcond0 with
      | is_gidx ?gidx = true => remember gidx as llt_gidx eqn:Hllt_gidx; symmetry in Hllt_gidx
      end.
      match type of Prop0 with
      | glock ?a @ ?gidx = None => remember gidx as data_gidx eqn:Hdata_gidx; symmetry in Hdata_gidx
      end.
      rewrite_oracle_rel rel_oracle C2; simpl in *.
      repeat (grewrite; simpl). simpl_htarget.
      inversion Hspec. eexists; split. reflexivity.
      constructor; destruct Hrel; simpl; try assumption; try reflexivity.
    - rewrite_oracle_rel rel_oracle C2.
      repeat destruct_con.
      match type of Hcond0 with
      | is_gidx ?gidx = true => remember gidx as llt_gidx eqn:Hllt_gidx; symmetry in Hllt_gidx
      end.
      match type of Prop0 with
      | glock ?a @ ?gidx = None => remember gidx as data_gidx eqn:Hdata_gidx; symmetry in Hdata_gidx
      end.
      repeat (grewrite; simpl).
      repeat (grewrite; try simpl_htarget; simpl).
      inversion Hspec. eexists; split. reflexivity.
      constructor; destruct Hrel; simpl; try assumption; try reflexivity.
    - rewrite_oracle_rel rel_oracle C2.
      repeat (grewrite; simpl).
      repeat (grewrite; try simpl_htarget; simpl).
      inversion Hspec. eexists; split. reflexivity.
      constructor; destruct Hrel; simpl; try assumption; try reflexivity.
  Qed.

End Refine.


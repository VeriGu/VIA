Require Import RefProofDeps.
Require Import RData.
Require Import EventReplay.
Require Import MoverTypes.
Require Import Constants.
Require Import CommonLib.
Require Import RefTactics.
Require Import TableDataOpsIntro.Spec.
Require Import TableDataOpsRef1.Spec.
Require Import TableDataOpsRef2.Specs.table_map2.
Require Import TableDataOpsRef2.LowSpecs.table_map2.
Require Import TableDataOpsRef2.RefProof.RefRel.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.shiftl Z.shiftr Z.land Z.lor.

Section Refine.

  Hint Unfold
       table_map_spec
       table_map1_spec
    .

  Lemma table_map2_spec_exists:
    forall habd habd'  labd g_rd map_addr level res
      (Hspec: table_map2_spec g_rd map_addr level habd = Some (habd', res))
      (Hrel: relate_RData habd labd),
    exists labd', table_map2_spec0 g_rd map_addr level labd = Some (labd', res) /\ relate_RData habd' labd'.
  Proof.
    Local Opaque peq ptr_eq.
    intros. duplicate Hrel. destruct D. clear hrepl lrepl. destruct g_rd.
    unfold table_map2_spec, table_map2_spec0 in *.
    unfold Assertion in *. rm_bind Hspec; rm_bind'. simpl in *.
    unfold Assertion; rm_bind'; grewrite.
    repeat simpl_hyp Hspec; extract_prop_dec; simpl_query_oracle; rm_bind'; grewrite.
    - rewrite_oracle_rel rel_oracle C5.
      repeat (grewrite; try simpl_htarget; simpl).
      unfold map_table in *. simpl in *. autounfold in *. simpl in *. grewrite.
      repeat simpl_hyp Hspec; simpl; inversion Hspec; clear H0; grewrite;
        (eexists; split; [reflexivity| constructor; destruct Hrel; simpl; try assumption; try reflexivity]).
    - rewrite_oracle_rel rel_oracle C5.
      repeat (grewrite; try simpl_htarget; simpl).
      assert(Hwalk: repl habd (oracle habd
                                      (EVT CPU_ID (RTT_WALK (g_rtt (gnorm (gs (share habd)) @ z)) z0 2) :: oracle habd (log habd) ++ log habd)) s = Some s).
      destruct Hrel. grewrite. destruct valid_ho0. rewrite Hright_log_nil. reflexivity.
      eapply RightLogMover.
      apply walk_right. omega. omega. apply RightLogOracle.
      rewrite_oracle_rel rel_oracle Hwalk; simpl in *.
      repeat (grewrite; try simpl_htarget; simpl).
      unfold map_table in *. simpl in *. autounfold in *. simpl in *. grewrite.
      repeat simpl_hyp Hspec; simpl; inversion Hspec; clear H0; grewrite;
        (eexists; split; [reflexivity| constructor; destruct Hrel; simpl; try assumption; try reflexivity]).
    - rewrite_oracle_rel rel_oracle C5.
      repeat (grewrite; try simpl_htarget; simpl). inversion Hspec.
      (eexists; split; [reflexivity| constructor; destruct Hrel; simpl; try assumption; try reflexivity]).
    - rewrite_oracle_rel rel_oracle C5.
      repeat (grewrite; try simpl_htarget; simpl).
      inversion Hspec. eexists; split. reflexivity.
      constructor; destruct Hrel; simpl; try assumption; try reflexivity.
    - rewrite_oracle_rel rel_oracle C5.
      repeat (grewrite; try simpl_htarget; simpl).
      inversion Hspec. eexists; split. reflexivity.
      constructor; destruct Hrel; simpl; try assumption; try reflexivity.
  Qed.

End Refine.


Require Import CodeProofDeps.
Require Import Ident.
Require Import Constants.
Require Import RData.
Require Import EventReplay.
Require Import MoverTypes.
Require Import CommonLib.
Require Import TableDataOpsIntro.Spec.
Require Import TableDataOpsRef2.Spec.
Require Import TableDataOpsRef2.Layer.
Require Import TableDataOpsRef3.Code.table_unmap3.

Require Import TableDataOpsRef3.LowSpecs.table_unmap3.

Local Open Scope Z_scope.

Section CodeProof.

  Context `{real_params: RealParams}.
  Context {memb} `{Hmemx: Mem.MemoryModelX memb}.
  Context `{Hmwd: UseMemWithData memb}.

  Let mem := mwd (cdata RData).

  Context `{Hstencil: Stencil}.
  Context `{make_program_ops: !MakeProgramOps Clight.function type Clight.fundef type}.
  Context `{Hmake_program: !MakeProgram Clight.function type Clight.fundef type}.

  Let L : compatlayer (cdata RData) :=
    _table_unmap ↦ gensem table_unmap_spec
      ⊕ _table_unmap2 ↦ gensem table_unmap2_spec
  .

  Local Instance: ExternalCallsOps mem := CompatExternalCalls.compatlayer_extcall_ops L.
  Local Instance: CompilerConfigOps mem := CompatExternalCalls.compatlayer_compiler_config_ops L.

  Section BodyProof.

    Context `{Hwb: WritableBlockOps}.
    Variable (sc: stencil).
    Variables (ge: genv) (STENCIL_MATCHES: stencil_matches sc ge).

    Variable b_table_unmap: block.
    Hypothesis h_table_unmap_s : Genv.find_symbol ge _table_unmap = Some b_table_unmap.
    Hypothesis h_table_unmap_p : Genv.find_funct_ptr ge b_table_unmap
                                 = Some (External (EF_external _table_unmap
                                                  (signature_of_type (Tcons Tptr (Tcons tulong (Tcons tulong Tnil))) tulong cc_default))
                                        (Tcons Tptr (Tcons tulong (Tcons tulong Tnil))) tulong cc_default).
    Local Opaque table_unmap_spec.

    Variable b_table_unmap2: block.
    Hypothesis h_table_unmap2_s : Genv.find_symbol ge _table_unmap2 = Some b_table_unmap2.
    Hypothesis h_table_unmap2_p : Genv.find_funct_ptr ge b_table_unmap2
                                  = Some (External (EF_external _table_unmap2
                                                   (signature_of_type (Tcons Tptr (Tcons tulong (Tcons tulong Tnil))) tulong cc_default))
                                         (Tcons Tptr (Tcons tulong (Tcons tulong Tnil))) tulong cc_default).
    Local Opaque table_unmap2_spec.

    Lemma table_unmap3_body_correct:
      forall m d d' env le g_rd_base g_rd_offset map_addr level res
             (Henv: env = PTree.empty _)
             (Hinv: high_level_invariant d)
             (HPTg_rd: PTree.get _g_rd le = Some (Vptr g_rd_base (Int.repr g_rd_offset)))
             (HPTmap_addr: PTree.get _map_addr le = Some (Vlong map_addr))
             (HPTlevel: PTree.get _level le = Some (Vlong level))
             (Hspec: table_unmap3_spec0 (g_rd_base, g_rd_offset) (VZ64 (Int64.unsigned map_addr)) (VZ64 (Int64.unsigned level)) d = Some (d', VZ64 (Int64.unsigned res))),
           exists le', (exec_stmt ge env le ((m, d): mem) table_unmap3_body E0 le' (m, d') (Out_return (Some (Vlong res, tulong)))).
    Proof.
      solve_code_proof Hspec table_unmap3_body; eexists; solve_proof_low.
    Qed.

  End BodyProof.

End CodeProof.

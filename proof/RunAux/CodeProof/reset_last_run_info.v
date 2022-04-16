Require Import CodeProofDeps.
Require Import Ident.
Require Import Constants.
Require Import RData.
Require Import EventReplay.
Require Import MoverTypes.
Require Import CommonLib.
Require Import AbsAccessor.Spec.
Require Import RealmExitHandler.Layer.
Require Import RunAux.Code.reset_last_run_info.

Require Import RunAux.LowSpecs.reset_last_run_info.

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
    _set_rec_last_run_info_esr ↦ gensem set_rec_last_run_info_esr_spec
  .

  Local Instance: ExternalCallsOps mem := CompatExternalCalls.compatlayer_extcall_ops L.
  Local Instance: CompilerConfigOps mem := CompatExternalCalls.compatlayer_compiler_config_ops L.

  Section BodyProof.

    Context `{Hwb: WritableBlockOps}.
    Variable (sc: stencil).
    Variables (ge: genv) (STENCIL_MATCHES: stencil_matches sc ge).

    Variable b_set_rec_last_run_info_esr: block.
    Hypothesis h_set_rec_last_run_info_esr_s : Genv.find_symbol ge _set_rec_last_run_info_esr = Some b_set_rec_last_run_info_esr.
    Hypothesis h_set_rec_last_run_info_esr_p : Genv.find_funct_ptr ge b_set_rec_last_run_info_esr
                                               = Some (External (EF_external _set_rec_last_run_info_esr
                                                                (signature_of_type (Tcons Tptr (Tcons tulong Tnil)) tvoid cc_default))
                                                      (Tcons Tptr (Tcons tulong Tnil)) tvoid cc_default).
    Local Opaque set_rec_last_run_info_esr_spec.

    Lemma reset_last_run_info_body_correct:
      forall m d d' env le rec_base rec_offset
             (Henv: env = PTree.empty _)
             (Hinv: high_level_invariant d)
             (HPTrec: PTree.get _rec le = Some (Vptr rec_base (Int.repr rec_offset)))
             (Hspec: reset_last_run_info_spec0 (rec_base, rec_offset) d = Some d'),
           exists le', (exec_stmt ge env le ((m, d): mem) reset_last_run_info_body E0 le' (m, d') Out_normal).
    Proof.
      solve_code_proof Hspec reset_last_run_info_body; eexists; solve_proof_low.
    Qed.

  End BodyProof.

End CodeProof.

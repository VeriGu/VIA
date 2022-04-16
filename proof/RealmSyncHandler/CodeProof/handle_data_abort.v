Require Import CodeProofDeps.
Require Import Ident.
Require Import Constants.
Require Import RData.
Require Import EventReplay.
Require Import MoverTypes.
Require Import CommonLib.
Require Import AbsAccessor.Spec.
Require Import RealmSyncHandlerAux.Spec.
Require Import RealmSyncHandlerAux.Layer.
Require Import RealmSyncHandler.Code.handle_data_abort.

Require Import RealmSyncHandler.LowSpecs.handle_data_abort.

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
    _sysreg_read ↦ gensem sysreg_read_spec
      ⊕ _access_in_par ↦ gensem access_in_par_spec
      ⊕ _set_rec_last_run_info_esr ↦ gensem set_rec_last_run_info_esr_spec
      ⊕ _esr_is_write ↦ gensem esr_is_write_spec
      ⊕ _get_write_value ↦ gensem get_write_value_spec
      ⊕ _set_rec_run_esr ↦ gensem set_rec_run_esr_spec
      ⊕ _set_rec_run_far ↦ gensem set_rec_run_far_spec
      ⊕ _set_rec_run_hpfar ↦ gensem set_rec_run_hpfar_spec
      ⊕ _set_rec_run_emulated_write_val ↦ gensem set_rec_run_emulated_write_val_spec
  .

  Local Instance: ExternalCallsOps mem := CompatExternalCalls.compatlayer_extcall_ops L.
  Local Instance: CompilerConfigOps mem := CompatExternalCalls.compatlayer_compiler_config_ops L.

  Section BodyProof.

    Context `{Hwb: WritableBlockOps}.
    Variable (sc: stencil).
    Variables (ge: genv) (STENCIL_MATCHES: stencil_matches sc ge).

    Variable b_sysreg_read: block.
    Hypothesis h_sysreg_read_s : Genv.find_symbol ge _sysreg_read = Some b_sysreg_read.
    Hypothesis h_sysreg_read_p : Genv.find_funct_ptr ge b_sysreg_read
                                 = Some (External (EF_external _sysreg_read
                                                  (signature_of_type (Tcons tuint Tnil) tulong cc_default))
                                        (Tcons tuint Tnil) tulong cc_default).
    Local Opaque sysreg_read_spec.

    Variable b_access_in_par: block.
    Hypothesis h_access_in_par_s : Genv.find_symbol ge _access_in_par = Some b_access_in_par.
    Hypothesis h_access_in_par_p : Genv.find_funct_ptr ge b_access_in_par
                                   = Some (External (EF_external _access_in_par
                                                    (signature_of_type (Tcons Tptr (Tcons tulong (Tcons tulong Tnil))) tuint cc_default))
                                          (Tcons Tptr (Tcons tulong (Tcons tulong Tnil))) tuint cc_default).
    Local Opaque access_in_par_spec.

    Variable b_set_rec_last_run_info_esr: block.
    Hypothesis h_set_rec_last_run_info_esr_s : Genv.find_symbol ge _set_rec_last_run_info_esr = Some b_set_rec_last_run_info_esr.
    Hypothesis h_set_rec_last_run_info_esr_p : Genv.find_funct_ptr ge b_set_rec_last_run_info_esr
                                               = Some (External (EF_external _set_rec_last_run_info_esr
                                                                (signature_of_type (Tcons Tptr (Tcons tulong Tnil)) tvoid cc_default))
                                                      (Tcons Tptr (Tcons tulong Tnil)) tvoid cc_default).
    Local Opaque set_rec_last_run_info_esr_spec.

    Variable b_esr_is_write: block.
    Hypothesis h_esr_is_write_s : Genv.find_symbol ge _esr_is_write = Some b_esr_is_write.
    Hypothesis h_esr_is_write_p : Genv.find_funct_ptr ge b_esr_is_write
                                  = Some (External (EF_external _esr_is_write
                                                   (signature_of_type (Tcons tulong Tnil) tuint cc_default))
                                         (Tcons tulong Tnil) tuint cc_default).
    Local Opaque esr_is_write_spec.

    Variable b_get_write_value: block.
    Hypothesis h_get_write_value_s : Genv.find_symbol ge _get_write_value = Some b_get_write_value.
    Hypothesis h_get_write_value_p : Genv.find_funct_ptr ge b_get_write_value
                                     = Some (External (EF_external _get_write_value
                                                      (signature_of_type (Tcons Tptr (Tcons tulong Tnil)) tulong cc_default))
                                            (Tcons Tptr (Tcons tulong Tnil)) tulong cc_default).
    Local Opaque get_write_value_spec.

    Variable b_set_rec_run_esr: block.
    Hypothesis h_set_rec_run_esr_s : Genv.find_symbol ge _set_rec_run_esr = Some b_set_rec_run_esr.
    Hypothesis h_set_rec_run_esr_p : Genv.find_funct_ptr ge b_set_rec_run_esr
                                     = Some (External (EF_external _set_rec_run_esr
                                                      (signature_of_type (Tcons tulong Tnil) tvoid cc_default))
                                            (Tcons tulong Tnil) tvoid cc_default).
    Local Opaque set_rec_run_esr_spec.

    Variable b_set_rec_run_far: block.
    Hypothesis h_set_rec_run_far_s : Genv.find_symbol ge _set_rec_run_far = Some b_set_rec_run_far.
    Hypothesis h_set_rec_run_far_p : Genv.find_funct_ptr ge b_set_rec_run_far
                                     = Some (External (EF_external _set_rec_run_far
                                                      (signature_of_type (Tcons tulong Tnil) tvoid cc_default))
                                            (Tcons tulong Tnil) tvoid cc_default).
    Local Opaque set_rec_run_far_spec.

    Variable b_set_rec_run_hpfar: block.
    Hypothesis h_set_rec_run_hpfar_s : Genv.find_symbol ge _set_rec_run_hpfar = Some b_set_rec_run_hpfar.
    Hypothesis h_set_rec_run_hpfar_p : Genv.find_funct_ptr ge b_set_rec_run_hpfar
                                       = Some (External (EF_external _set_rec_run_hpfar
                                                        (signature_of_type (Tcons tulong Tnil) tvoid cc_default))
                                              (Tcons tulong Tnil) tvoid cc_default).
    Local Opaque set_rec_run_hpfar_spec.

    Variable b_set_rec_run_emulated_write_val: block.
    Hypothesis h_set_rec_run_emulated_write_val_s : Genv.find_symbol ge _set_rec_run_emulated_write_val = Some b_set_rec_run_emulated_write_val.
    Hypothesis h_set_rec_run_emulated_write_val_p : Genv.find_funct_ptr ge b_set_rec_run_emulated_write_val
                                                    = Some (External (EF_external _set_rec_run_emulated_write_val
                                                                     (signature_of_type (Tcons tulong Tnil) tvoid cc_default))
                                                           (Tcons tulong Tnil) tvoid cc_default).
    Local Opaque set_rec_run_emulated_write_val_spec.

    Lemma handle_data_abort_body_correct:
      forall m d d' env le rec_base rec_offset esr
             (Henv: env = PTree.empty _)
             (Hinv: high_level_invariant d)
             (HPTrec: PTree.get _rec le = Some (Vptr rec_base (Int.repr rec_offset)))
             (HPTesr: PTree.get _esr le = Some (Vlong esr))
             (Hspec: handle_data_abort_spec0 (rec_base, rec_offset) (VZ64 (Int64.unsigned esr)) d = Some d'),
           exists le', (exec_stmt ge env le ((m, d): mem) handle_data_abort_body E0 le' (m, d') Out_normal).
    Proof.
      solve_code_proof Hspec handle_data_abort_body; eexists; solve_proof_low.
    Qed.

  End BodyProof.

End CodeProof.

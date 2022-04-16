Require Import Coqlib.
Require Import AST.
Require Import Integers.
Require Import Smallstep.
Require Import Events.
Require Import Globalenvs.
Require Import Memory.
Require Import Values.
Require Import Constants.
Require Import RData.
Require Import Assembly.Asm.
Require Import CommonLib.

Definition null_signature :=
  {| sig_args := nil;
     sig_res := None;
     sig_cc := cc_default |}.

Parameter rmm_handler: Z.
Definition handle_std_service := 1.
Definition el3_smc_handler := 2.
Definition save_el2_state := 3.
Definition restore_el2_state := 4.
Definition realm_smc_handler := 5.
Definition ns_smc_handler := 6.
Definition el3_sync_lel := 7.
Definition smc_el3_sync_lel := 8.
Definition unrecognized_smc_return := 9.
Definition el3_sync_unimplemented := 999.
Parameter handle_std_service_sig: signature.

Definition el3_sync_lel_insn : list instruction :=
  (Pstp' x0 x1 SP (-16))
    :: (Pstp' x2 x3 SP (-16))
    :: (Pstp' x4 lr SP (-16))
    :: (Pmov x3 x0)
    :: (Pmrs x0 esr_el3)
    :: (Pandimm x1 x0 ESR_EC)
    :: (Pmovimm x2 ESR_EC_SMC)
    :: (Pcmp x1 x2)
    :: (Pbc TCeq smc_el3_sync_lel)
    :: (Pb el3_sync_unimplemented)
    :: (Plabel smc_el3_sync_lel)
    :: (Pandimm x1 x0 ESR_EC_SMC_IMM16)
    :: (Pbc TCne el3_sync_unimplemented)
    :: (Pmov x0 x3)
    :: (Pmrs x1 scr_el3)
    :: (Pldrimm x4 SCR_WORLD_MASK)
    :: (Pand x1 x1 x4)
    :: (Pcmpimm x1 SCR_REALM_WORLD)
    :: (Pbc TCeq realm_smc_handler)
    :: (Pbic x1 x3 SMC_ARM_ARCH_CALL_MASK)
    :: (Pldrimm x2 SMC_ARM_ARCH_CALL_BASE)
    :: (Pcmp x1 x2)
    :: (Pbc TCne el3_sync_unimplemented)
    :: (Pandimm x0 x3 SMC_ARM_ARCH_CALL_MASK)
    :: (Pb ns_smc_handler)
    :: (Plabel el3_sync_unimplemented)
    :: (Pstuck)
    :: (Plabel realm_smc_handler)
    :: (Pbic x1 x0 SMC_STD_CALL_MASK)
    :: (Pldrimm x2 SMC_STD_CALL_BASE)
    :: (Pcmp x1 x2)
    :: (Pbc TCeq el3_smc_handler)
    :: (Pmrs x0 tpidr_el3)
    :: (Paddimm x0 x0 CPUSTATE_REALM_OFFSET)
    :: (Pbl save_el2_state null_signature)
    :: (Pmrs x0 tpidr_el3)
    :: (Paddimm x0 x0 CPUSTATE_NS_OFFSET)
    :: (Pbl restore_el2_state null_signature)
    :: (Pldrimm x1 SCR_EL3_NS)
    :: (Pmsr scr_el3 x1)
    :: (Pldp' x4 lr SP 16)
    :: (Pldp' x2 x3 SP 16)
    :: (Pldp' x0 x1 SP 16)
    :: (Peret)
    :: (Plabel ns_smc_handler)
    :: (Pmrs x0 tpidr_el3)
    :: (Paddimm x0 x0 CPUSTATE_NS_OFFSET)
    :: (Pbl save_el2_state null_signature)
    :: (Pmrs x0 tpidr_el3)
    :: (Paddimm x0 x0 CPUSTATE_REALM_OFFSET)
    :: (Pbl restore_el2_state null_signature)
    :: (Pldrimm x1 rmm_handler)
    :: (Pmsr elr_el3 x1)
    :: (Pldrimm x1 SCR_EL3_REALM)
    :: (Pmsr scr_el3 x1)
    :: (Pldp' x4 lr SP 16)
    :: (Pldp' x2 x3 SP 16)
    :: (Pldp' x0 x1 SP 16)
    :: (Peret)
    :: (Plabel el3_smc_handler)
    :: (Pldp' x4 lr SP 16)
    :: (Pldp' x2 x3 SP 16)
    :: (Pldp' x0 x1 SP 16)
    :: (Pstp' x29 lr SP (-16))
    :: (Pstr' x18 SP (-16))
    :: (Pbl handle_std_service handle_std_service_sig)
    :: (Pldr' x18 SP 16)
    :: (Pldp' x29 lr SP 16)
    :: (Peret)
    :: nil.

Definition restore_el2_state_insn :=
	(Pldp	x1 x2 x0 0)
    :: (Pmsr	spsr_el3 x1)
    :: (Pmsr	elr_el3 x2)
    :: (Pldp	x1 x2 x0 16)
    :: (Pmsr	actlr_el2 x1)
    :: (Pmsr	afsr0_el2 x2)
    :: (Pldp	x1 x2 x0 (16*2))
    :: (Pmsr	afsr1_el2 x1)
    :: (Pmsr	amair_el2 x2)
    :: (Pldp	x1 x2 x0 (16*3))
    :: (Pmsr	cnthctl_el2 x1)
    :: (Pmsr	cntvoff_el2 x2)
    :: (Pldp	x1 x2 x0 (16*4))
    :: (Pmsr	cptr_el2 x1)
    :: (Pmsr	elr_el2 x2)
    :: (Pldp	x1 x2 x0 (16*5))
	  :: (Pmsr	esr_el2 x1)
    :: (Pmsr	far_el2 x2)
    :: (Pldp	x1 x2 x0 (16*6))
    :: (Pmsr	hacr_el2 x1)
    :: (Pmsr	hcr_el2 x2)
    :: (Pldp	x1 x2 x0 (16*7))
    :: (Pmsr	hpfar_el2 x1)
    :: (Pmsr	hstr_el2 x2)
    :: (Pldp	x1 x2 x0 (16*8))
    :: (Pmsr	mair_el2 x1)
    :: (Pmsr	mpam_el2 x2)
    :: (Pldp	x1 x2 x0 (16*9))
    :: (Pmsr	mpamhcr_el2 x1)
    :: (Pmsr	pmscr_el2 x2)
    :: (Pldp	x1 x2 x0 (16*10))
    :: (Pmsr	sctlr_el2 x1)
    :: (Pmsr	scxtnum_el2 x2)
    :: (Pldp	x1 x2 x0 (16*11))
    :: (Pmsr	sp_el2 x1)
    :: (Pmsr	spsr_el2 x2)
    :: (Pldp	x1 x2 x0 (16*12))
    :: (Pmsr	tcr_el2 x1)
    :: (Pmsr	tfsr_el2 x2)
    :: (Pldp	x1 x2 x0 (16*13))
    :: (Pmsr	tpidr_el2 x1)
    :: (Pmsr	trfcr_el2 x2)
    :: (Pldp	x1 x2 x0 (16*14))
    :: (Pmsr	ttbr0_el2 x1)
    :: (Pmsr	ttbr1_el2 x2)
    :: (Pldp	x1 x2 x0 (16*15))
    :: (Pmsr	vbar_el2 x1)
    :: (Pmsr	vdisr_el2 x2)
    :: (Pldp	x1 x2 x0 (16*16))
    :: (Pmsr	vmpidr_el2 x1)
    :: (Pmsr	vncr_el2 x2)
    :: (Pldp	x1 x2 x0 (16*17))
    :: (Pmsr	vpidr_el2 x1)
    :: (Pmsr	vsesr_el2 x2)
    :: (Pldp	x1 x2 x0 (16*18))
    :: (Pmsr	vstcr_el2 x1)
    :: (Pmsr	vsttbr_el2 x2)
    :: (Pldp	x1 x2 x0 (16*19))
    :: (Pmsr	vtcr_el2 x1)
    :: (Pmsr	vttbr_el2 x2)
    :: (Pldr	x1 x0 (16*20))
    :: (Pmsr	zcr_el2 x1)
    :: (Pret x0)
    :: nil.

Definition save_el2_state_insn :=
	(Pmrs x1 spsr_el3)
	:: (Pmrs x2 elr_el3)
  :: (Pstp x1 x2 x0 0)
	:: (Pmrs x1 actlr_el2)
	:: (Pmrs x2 afsr0_el2)
  :: (Pstp x1 x2 x0 (16*1))
	:: (Pmrs x1 afsr1_el2)
	:: (Pmrs x2 amair_el2)
  :: (Pstp x1 x2 x0 (16*2))
	:: (Pmrs x1 cnthctl_el2)
	:: (Pmrs x2 cntvoff_el2)
  :: (Pstp x1 x2 x0 (16*3))
	:: (Pmrs x1 cptr_el2)
	:: (Pmrs x2 elr_el2)
  :: (Pstp x1 x2 x0 (16*4))
	:: (Pmrs x1 esr_el2)
	:: (Pmrs x2 far_el2)
  :: (Pstp x1 x2 x0 (16*5))
	:: (Pmrs x1 hacr_el2)
	:: (Pmrs x2 hcr_el2)
  :: (Pstp x1 x2 x0 (16*6))
	:: (Pmrs x1 hpfar_el2)
	:: (Pmrs x2 hstr_el2)
  :: (Pstp x1 x2 x0 (16*7))
	:: (Pmrs x1 mair_el2)
	:: (Pmrs x2 mpam_el2)
  :: (Pstp x1 x2 x0 (16*8))
	:: (Pmrs x1 mpamhcr_el2)
	:: (Pmrs x2 pmscr_el2)
  :: (Pstp x1 x2 x0 (16*9))
	:: (Pmrs x1 sctlr_el2)
	:: (Pmrs x2 scxtnum_el2)
  :: (Pstp x1 x2 x0 (16*10))
	:: (Pmrs x1 sp_el2)
	:: (Pmrs x2 spsr_el2)
  :: (Pstp x1 x2 x0 (16*11))
	:: (Pmrs x1 tcr_el2)
	:: (Pmrs x2 tfsr_el2)
  :: (Pstp x1 x2 x0 (16*12))
	:: (Pmrs x1 tpidr_el2)
	:: (Pmrs x2 trfcr_el2)
  :: (Pstp x1 x2 x0 (16*13))
	:: (Pmrs x1 ttbr0_el2)
	:: (Pmrs x2 ttbr1_el2)
  :: (Pstp x1 x2 x0 (16*14))
	:: (Pmrs x1 vbar_el2)
	:: (Pmrs x2 vdisr_el2)
  :: (Pstp x1 x2 x0 (16*15))
	:: (Pmrs x1 vmpidr_el2)
	:: (Pmrs x2 vncr_el2)
  :: (Pstp x1 x2 x0 (16*16))
	:: (Pmrs x1 vpidr_el2)
	:: (Pmrs x2 vsesr_el2)
  :: (Pstp x1 x2 x0 (16*17))
	:: (Pmrs x1 vstcr_el2)
	:: (Pmrs x2 vsttbr_el2)
  :: (Pstp x1 x2 x0 (16*18))
	:: (Pmrs x1 vtcr_el2)
	:: (Pmrs x2 vttbr_el2)
  :: (Pstp x1 x2 x0 (16*19))
	:: (Pmrs x1 zcr_el2)
	:: (Pstr	x1 x0 (16*20))
	:: (Pret x0)
  :: nil.

Definition run_realm_insn :=
  (Psubimm SP SP (16*6))
    :: (Pstp x19 x20 SP (16*0))
    :: (Pstp x21 x22 SP (16*1))
    :: (Pstp x23 x24 SP (16*2))
    :: (Pstp x25 x26 SP (16*3))
    :: (Pstp x27 x28 SP (16*4))
    :: (Pstp x29 x30 SP (16*5))
    :: (Pstp' x0 XZR SP (-16))
    :: (Pldp x2 x3 x0 (16*1))
    :: (Pldp x4 x5 x0 (16*2))
    :: (Pldp x6 x7 x0 (16*3))
    :: (Pldp x8 x9 x0 (16*4))
    :: (Pldp x10 x11 x0 (16*5))
    :: (Pldp x12 x13 x0 (16*6))
    :: (Pldp x14 x15 x0 (16*7))
    :: (Pldp x16 x17 x0 (16*8))
    :: (Pldp x18 x19 x0 (16*9))
    :: (Pldp x20 x21 x0 (16*10))
    :: (Pldp x22 x23 x0 (16*11))
    :: (Pldp x24 x25 x0 (16*12))
    :: (Pldp x26 x27 x0 (16*13))
    :: (Pldp x28 x29 x0 (16*14))
    :: (Pldr x30 x0 (16*15))
    :: (Pldp x0 x1 x0 (16*0))
    :: (Peret)
    :: nil.

Definition realm_exit_insn :=
	(Pstp' x0 x1 SP (-16))
    :: (Pmovimm x0 ARM_EXCEPTION_SYNC_LEL)
    :: (Pldr x1 SP 16)
    :: (Pstp x2 x3 x1 (16*1))
    :: (Pstp x4 x5 x1 (16*2))
    :: (Pstp x6 x7 x1 (16*3))
    :: (Pstp x8 x9 x1 (16*4))
    :: (Pstp x10 x11 x1 (16*5))
    :: (Pstp x12 x13 x1 (16*6))
    :: (Pstp x14 x15 x1 (16*7))
    :: (Pstp x16 x17 x1 (16*8))
    :: (Pstp x18 x19 x1 (16*9))
    :: (Pstp x20 x21 x1 (16*10))
    :: (Pstp x22 x23 x1 (16*11))
    :: (Pstp x24 x25 x1 (16*12))
    :: (Pstp x26 x27 x1 (16*13))
    :: (Pstp x28 x29 x1 (16*14))
    :: (Pstr x30 x1 (16*15))
    :: (Pldp x2 x3 SP 0)
    :: (Pstp x2 x3 x1 (16*0))
    :: (Paddimm SP SP 32)
    :: (Pldp x19 x20 SP (16*0))
    :: (Pldp x21 x22 SP (16*1))
    :: (Pldp x23 x24 SP (16*2))
    :: (Pldp x25 x26 SP (16*3))
    :: (Pldp x27 x28 SP (16*4))
    :: (Pldp x29 x30 SP (16*5))
    :: (Paddimm SP SP (16*6))
    :: (Pret x0)
    :: nil.

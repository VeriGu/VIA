Require Import Coqlib.

Definition _assert_cond := 100000000%positive.
Definition _null_ptr := 100000001%positive.
Definition _is_null := 100000002%positive.
Definition _ptr_eq := 100000003%positive.
Definition _ptr_is_err := 100000004%positive.
Definition _shiftl := 100000005%positive.
Definition _granule_lock := 100000006%positive.
Definition _granule_unlock := 100000007%positive.
Definition _granule_addr := 100000008%positive.
Definition _addr_to_granule := 100000009%positive.
Definition _find_granule := 100000010%positive.
Definition _find_lock_granule := 100000011%positive.
Definition _find_lock_unused_granule := 100000012%positive.
Definition _find_lock_three_delegated_granules := 100000013%positive.
Definition _get_locked_granule := 100000014%positive.
Definition _granule_get := 100000015%positive.
Definition _granule_refcount_inc := 100000016%positive.
Definition _granule_put := 100000017%positive.
Definition _granule_refcount_dec := 100000018%positive.
Definition _atomic_granule_get := 100000019%positive.
Definition _atomic_granule_put := 100000020%positive.
Definition _atomic_granule_put_release := 100000021%positive.
Definition _granule_get_state := 100000022%positive.
Definition _granule_set_state := 100000023%positive.
Definition _granule_map := 100000024%positive.
Definition _buffer_unmap := 100000025%positive.
Definition _granule_memzero := 100000026%positive.
Definition _granule_memzero_mapped := 100000027%positive.
Definition _get_g_data_rd := 100000028%positive.
Definition _get_g_rec_rd := 100000029%positive.
Definition _get_rec_g_rec_list := 100000030%positive.
Definition _get_g_rtt_refcount := 100000031%positive.
Definition _set_g_rec_rd := 100000032%positive.
Definition _set_g_rtt_rd := 100000033%positive.
Definition _get_rd_g_rtt := 100000034%positive.
Definition _get_rd_g_rec_list := 100000035%positive.
Definition _get_rd_state := 100000036%positive.
Definition _get_rd_par_base := 100000037%positive.
Definition _get_rd_par_end := 100000038%positive.
Definition _get_rd_measurement := 100000039%positive.
Definition _set_rd_measurement_algo := 100000040%positive.
Definition _set_rd_state := 100000041%positive.
Definition _set_rd_par_base := 100000042%positive.
Definition _set_rd_par_end := 100000043%positive.
Definition _set_rd_g_rtt := 100000044%positive.
Definition _set_rd_g_rec_list := 100000045%positive.
Definition _get_rec_params_flags := 100000046%positive.
Definition _get_rec_rec_idx := 100000047%positive.
Definition _get_rec_dispose_pending := 100000048%positive.
Definition _get_rec_pc := 100000049%positive.
Definition _get_rec_pstate := 100000050%positive.
Definition _get_rec_last_run_info_esr := 100000051%positive.
Definition _init_rec_read_only := 100000052%positive.
Definition _set_rec_g_rd := 100000053%positive.
Definition _set_rec_g_rec_list := 100000054%positive.
Definition _set_rec_par_base := 100000055%positive.
Definition _set_rec_par_end := 100000056%positive.
Definition _get_rec_runnable := 100000057%positive.
Definition _set_rec_runnable := 100000058%positive.
Definition _set_rec_regs := 100000059%positive.
Definition _set_rec_pc := 100000060%positive.
Definition _set_rec_pstate := 100000061%positive.
Definition _set_rvic_mask_bits := 100000062%positive.
Definition _set_rec_sysregs := 100000063%positive.
Definition _set_rec_common_sysregs := 100000064%positive.
Definition _set_rec_dispose_pending := 100000065%positive.
Definition _set_rec_last_run_info_esr := 100000066%positive.
Definition _get_rec_run_gprs := 100000067%positive.
Definition _get_rec_run_is_emulated_mmio := 100000068%positive.
Definition _get_rec_run_emulated_read_val := 100000069%positive.
Definition _pgte_read := 100000070%positive.
Definition _pgte_write := 100000071%positive.
Definition _link_table := 100000072%positive.
Definition _set_mapping := 100000073%positive.
Definition _set_retval := 100000074%positive.
Definition _realm_get_rec_entry := 100000075%positive.
Definition _realm_set_rec_entry := 100000076%positive.
Definition _get_wi_g_llt := 100000077%positive.
Definition _get_wi_index := 100000078%positive.
Definition _set_wi_last_level := 100000079%positive.
Definition _set_wi_g_llt := 100000080%positive.
Definition _set_wi_index := 100000081%positive.
Definition _get_realm_params_par_base := 100000082%positive.
Definition _get_realm_params_par_size := 100000083%positive.
Definition _get_realm_params_rtt_addr := 100000084%positive.
Definition _get_realm_params_rec_list_addr := 100000085%positive.
Definition _get_realm_params_measurement_algo := 100000086%positive.
Definition _get_rec_params_gprs := 100000087%positive.
Definition _get_rec_params_pc := 100000088%positive.
Definition _is_addr_in_par := 100000089%positive.
Definition _mpidr_is_valid := 100000090%positive.
Definition _mpidr_to_rec_idx := 100000091%positive.
Definition _addr_to_idx := 100000092%positive.
Definition _entry_to_phys := 100000093%positive.
Definition _entry_is_table := 100000094%positive.
Definition _is_rec_valid := 100000095%positive.
Definition _stage2_tlbi_ipa := 100000096%positive.
Definition _esr_srt := 100000097%positive.
Definition _access_mask := 100000098%positive.
Definition _esr_sign_extend := 100000099%positive.
Definition _access_len := 100000100%positive.
Definition _esr_sixty_four := 100000101%positive.
Definition _get_rec_regs := 100000102%positive.
Definition _get_rec_par_base := 100000103%positive.
Definition _get_rec_par_end := 100000104%positive.
Definition _set_rec_dispose_addr := 100000105%positive.
Definition _set_rec_dispose_size := 100000106%positive.
Definition _set_rec_run_exit_reason := 100000107%positive.
Definition _set_rec_run_disposed_addr := 100000108%positive.
Definition _get_psci_result_x0 := 100000109%positive.
Definition _get_psci_result_x1 := 100000110%positive.
Definition _get_psci_result_x2 := 100000111%positive.
Definition _get_psci_result_x3 := 100000112%positive.
Definition _get_psci_result_forward_x1 := 100000113%positive.
Definition _get_psci_result_forward_x2 := 100000114%positive.
Definition _get_psci_result_forward_x3 := 100000115%positive.
Definition _get_psci_result_forward_psci_call := 100000116%positive.
Definition _set_psci_result_x0 := 100000117%positive.
Definition _set_psci_result_x1 := 100000118%positive.
Definition _set_psci_result_x2 := 100000119%positive.
Definition _set_psci_result_x3 := 100000120%positive.
Definition _set_psci_result_forward_psci_call := 100000121%positive.
Definition _set_psci_result_forward_x1 := 100000122%positive.
Definition _get_rec_g_rd := 100000123%positive.
Definition _get_rec_sysregs := 100000124%positive.
Definition _get_rec_common_sysregs := 100000125%positive.
Definition _get_rvic_pending_bits := 100000126%positive.
Definition _get_rvic_mask_bits := 100000127%positive.
Definition _atomic_bit_set_release_64 := 100000128%positive.
Definition _atomic_bit_clear_release_64 := 100000129%positive.
Definition _test_bit_acquire_64 := 100000130%positive.
Definition _get_rec_g_rec := 100000131%positive.
Definition _get_rec_rvic_enabled := 100000132%positive.
Definition _get_rec_rvic := 100000133%positive.
Definition _set_rvic_result_x0 := 100000134%positive.
Definition _set_rvic_result_x1 := 100000135%positive.
Definition _set_rvic_result_x2 := 100000136%positive.
Definition _set_rvic_result_x3 := 100000137%positive.
Definition _get_rvic_result_target := 100000138%positive.
Definition _get_rvic_result_ns_notify := 100000139%positive.
Definition _set_rvic_result_ns_notify := 100000140%positive.
Definition _set_rvic_result_target := 100000141%positive.
Definition _get_rvic_result_x0 := 100000142%positive.
Definition _get_rvic_result_x1 := 100000143%positive.
Definition _get_rvic_result_x2 := 100000144%positive.
Definition _get_rvic_result_x3 := 100000145%positive.
Definition _get_rvic_pending_bits_i := 100000146%positive.
Definition _find_next_set_bit := 100000147%positive.
Definition _set_rec_rvic_enabled := 100000148%positive.
Definition _resample_timer_signals := 100000149%positive.
Definition _get_bitmap_loc := 100000150%positive.
Definition _interrupt_bitmap_dword := 100000151%positive.
Definition _interrupt_bit := 100000152%positive.
Definition _get_target_rec := 100000153%positive.
Definition _set_target_rec := 100000154%positive.
Definition _get_rec_vtimer := 100000155%positive.
Definition _get_rec_ptimer := 100000156%positive.
Definition _get_timer_asserted := 100000157%positive.
Definition _get_timer_masked := 100000158%positive.
Definition _set_timer_masked := 100000159%positive.
Definition _emulate_timer_ctl_read := 100000160%positive.
Definition _timer_condition_met := 100000161%positive.
Definition _timer_is_masked := 100000162%positive.
Definition _sysreg_read := 100000163%positive.
Definition _sysreg_write := 100000164%positive.
Definition _set_rec_vtimer_asserted := 100000165%positive.
Definition _set_rec_ptimer_asserted := 100000166%positive.
Definition _set_rec_vtimer_masked := 100000167%positive.
Definition _get_rec_vtimer_masked := 100000168%positive.
Definition _set_rec_ptimer_masked := 100000169%positive.
Definition _get_rec_ptimer_masked := 100000170%positive.
Definition _clear_realm_stage2 := 100000171%positive.
Definition _get_ns_state := 100000172%positive.
Definition _set_ns_state := 100000173%positive.
Definition _esr_is_write := 100000174%positive.
Definition _set_rec_run_esr := 100000175%positive.
Definition _set_rec_run_far := 100000176%positive.
Definition _set_rec_run_hpfar := 100000177%positive.
Definition _set_rec_run_emulated_write_val := 100000178%positive.
Definition _is_addr_in_par_rec := 100000179%positive.
Definition _set_rec_run_target_rec := 100000180%positive.
Definition _set_rec_run_gprs := 100000181%positive.
Definition _read_idreg := 100000182%positive.
Definition _read_reg := 100000183%positive.
Definition _run_realm := 100000184%positive.
Definition _realm_exit := 100000185%positive.
Definition _get_cur_g_rec := 100000186%positive.
Definition _get_cur_rec := 100000187%positive.
Definition _ESR_EL2_SYSREG_IS_WRITE := 100000188%positive.
Definition _ESR_EL2_SYSREG_ISS_RT := 100000189%positive.
Definition _ns_granule_map := 100000190%positive.
Definition _ns_buffer_unmap := 100000191%positive.
Definition _ns_buffer_read_rec_params := 100000192%positive.
Definition _ns_buffer_read_realm_params := 100000193%positive.
Definition _ns_buffer_read_rec_run := 100000194%positive.
Definition _ns_buffer_write_rec_run := 100000195%positive.
Definition _ns_buffer_read_data := 100000196%positive.
Definition _max_ipa_size := 100000197%positive.
Definition _region_is_contained := 100000198%positive.
Definition _check_granule_idx := 100000199%positive.
Definition _addr_to_gidx := 100000200%positive.
Definition _find_spinlock := 100000201%positive.
Definition _spinlock_acquire := 100000202%positive.
Definition _spinlock_release := 100000203%positive.
Definition _get_pas := 100000204%positive.
Definition _set_pas := 100000205%positive.
Definition _tlbi_by_pa := 100000206%positive.
Definition _baremore_enter := 100000207%positive.
Definition _baremore_to_ns := 100000208%positive.
Definition _baremore_to_rmm := 100000209%positive.
Definition _baremore_return_rmm := 100000210%positive.
Definition _enter_rmm := 100000211%positive.
Definition _exit_rmm := 100000212%positive.
Definition _get_monitor_call_arg := 100000213%positive.
Definition _get_monitor_call_ret := 100000214%positive.
Definition _set_monitor_call := 100000215%positive.
Definition _measurement_start := 100000216%positive.
Definition _measurement_extend_rec_header := 100000217%positive.
Definition _measurement_extend_rec_regs := 100000218%positive.
Definition _measurement_extend_rec_pstate := 100000219%positive.
Definition _measurement_extend_rec_sysregs := 100000220%positive.
Definition _measurement_extend_data_header := 100000221%positive.
Definition _measurement_extend_data := 100000222%positive.
Definition _measurement_finish := 100000223%positive.
Definition _user_step := 100000224%positive.
Definition _addr_is_level_aligned := 100000225%positive.
Definition _barrier := 100000226%positive.
Definition _asc_mark_realm := 100000227%positive.
Definition _asc_mark_nonsecure := 100000228%positive.
Definition _el3_sync_lel := 100000229%positive.
Definition _smc_mark_realm := 100000230%positive.
Definition _smc_mark_nonsecure := 100000231%positive.
Definition _get_realm_params := 100000232%positive.
Definition _validate_realm_params := 100000233%positive.
Definition _init_rec_sysregs := 100000234%positive.
Definition _init_common_sysregs := 100000235%positive.
Definition _init_rec_regs := 100000236%positive.
Definition _init_rec_rvic_state := 100000237%positive.
Definition _rec_granule_measure := 100000238%positive.
Definition _granule_delegate_ops := 100000239%positive.
Definition _granule_undelegate_ops := 100000240%positive.
Definition _realm_activate_ops := 100000241%positive.
Definition _realm_create_ops := 100000242%positive.
Definition _realm_destroy_ops := 100000243%positive.
Definition _rec_create_ops := 100000244%positive.
Definition _rec_destroy_ops := 100000245%positive.
Definition _smc_granule_delegate := 100000246%positive.
Definition _smc_granule_undelegate := 100000247%positive.
Definition _smc_realm_activate := 100000248%positive.
Definition _smc_realm_create := 100000249%positive.
Definition _smc_realm_destroy := 100000250%positive.
Definition _smc_rec_create := 100000251%positive.
Definition _smc_rec_destroy := 100000252%positive.
Definition _psci_reset_rec := 100000253%positive.
Definition _find_lock_rec := 100000254%positive.
Definition _psci_cpu_on_target := 100000255%positive.
Definition _psci_lookup_target := 100000256%positive.
Definition _system_off_reboot := 100000257%positive.
Definition _psci_version := 100000258%positive.
Definition _psci_cpu_suspend := 100000259%positive.
Definition _psci_cpu_off := 100000260%positive.
Definition _psci_cpu_on := 100000261%positive.
Definition _psci_affinity_info := 100000262%positive.
Definition _psci_system_off := 100000263%positive.
Definition _psci_system_reset := 100000264%positive.
Definition _psci_features := 100000265%positive.
Definition _psci_rsi := 100000266%positive.
Definition _is_trusted_intid := 100000267%positive.
Definition _is_untrusted_intid := 100000268%positive.
Definition _rvic_test_flag := 100000269%positive.
Definition _find_lock_map_target_rec := 100000270%positive.
Definition _rvic_target_is_valid := 100000271%positive.
Definition _rvic_is_pending := 100000272%positive.
Definition _rvic_is_masked := 100000273%positive.
Definition _rvic_set_flag := 100000274%positive.
Definition _rvic_clear_flag := 100000275%positive.
Definition _validate_and_lookup_target := 100000276%positive.
Definition _need_ns_notify := 100000277%positive.
Definition _rvic_set_masked := 100000278%positive.
Definition _rvic_clear_masked := 100000279%positive.
Definition _set_clear_masked := 100000280%positive.
Definition _rvic_set_pending := 100000281%positive.
Definition _rvic_clear_pending := 100000282%positive.
Definition _check_timer_became_asserted := 100000283%positive.
Definition _check_pending_ptimers := 100000284%positive.
Definition _check_pending_vtimers := 100000285%positive.
Definition _save_sysreg_state := 100000286%positive.
Definition _restore_sysreg_state := 100000287%positive.
Definition _save_ns_state_sysreg_state := 100000288%positive.
Definition _restore_ns_state_sysreg_state := 100000289%positive.
Definition _save_realm_state := 100000290%positive.
Definition _restore_hcr_el2 := 100000291%positive.
Definition _restore_realm_state := 100000292%positive.
Definition _configure_realm_stage2 := 100000293%positive.
Definition _save_ns_state := 100000294%positive.
Definition _restore_ns_state := 100000295%positive.
Definition _handle_vtimer_sysreg_write := 100000296%positive.
Definition _handle_ptimer_sysreg_write := 100000297%positive.
Definition _handle_vtimer_sysreg_read := 100000298%positive.
Definition _handle_ptimer_sysreg_read := 100000299%positive.
Definition _access_in_par := 100000300%positive.
Definition _get_write_value := 100000301%positive.
Definition _handle_id_sysreg_trap := 100000302%positive.
Definition _handle_timer_sysreg_trap := 100000303%positive.
Definition _handle_icc_el1_sysreg_trap := 100000304%positive.
Definition _handle_data_abort := 100000305%positive.
Definition _handle_instruction_abort := 100000306%positive.
Definition _handle_realm_rsi := 100000307%positive.
Definition _handle_sysreg_access_trap := 100000308%positive.
Definition _handle_exception_sync := 100000309%positive.
Definition _handle_excpetion_irq_lel := 100000310%positive.
Definition _handle_realm_exit := 100000311%positive.
Definition _reset_last_run_info := 100000312%positive.
Definition _reset_disposed_info := 100000313%positive.
Definition _emulate_mmio_read := 100000314%positive.
Definition _complete_mmio_emulation := 100000315%positive.
Definition _complete_hvc_exit := 100000316%positive.
Definition _rec_run_loop := 100000317%positive.
Definition _smc_rec_run := 100000318%positive.
Definition _find_next_level_idx := 100000319%positive.
Definition _validate_table_commands := 100000320%positive.
Definition _granule_fill_table := 100000321%positive.
Definition _table_has_destroyed := 100000322%positive.
Definition _table_maps_block := 100000323%positive.
Definition _invalidate_page := 100000324%positive.
Definition _invalidate_block := 100000325%positive.
Definition _invalidate_pages_in_block := 100000326%positive.
Definition _data_granule_measure := 100000327%positive.
Definition _table_create_init_vacant := 100000328%positive.
Definition _table_create_init_absent := 100000329%positive.
Definition _table_create_init_present := 100000330%positive.
Definition _table_delete := 100000331%positive.
Definition _table_fold := 100000332%positive.
Definition _table_create_aux := 100000333%positive.
Definition _table_destroy_aux := 100000334%positive.
Definition _table_walk_lock_unlock := 100000335%positive.
Definition _table_create := 100000336%positive.
Definition _table_destroy := 100000337%positive.
Definition _table_map := 100000338%positive.
Definition _table_unmap := 100000339%positive.
Definition _data_create := 100000340%positive.
Definition _data_destroy := 100000341%positive.
Definition _table_create1 := 100000342%positive.
Definition _table_destroy1 := 100000343%positive.
Definition _table_map1 := 100000344%positive.
Definition _table_unmap1 := 100000345%positive.
Definition _data_create1 := 100000346%positive.
Definition _data_destroy1 := 100000347%positive.
Definition _table_create2 := 100000348%positive.
Definition _table_destroy2 := 100000349%positive.
Definition _table_map2 := 100000350%positive.
Definition _table_unmap2 := 100000351%positive.
Definition _data_create2 := 100000352%positive.
Definition _data_destroy2 := 100000353%positive.
Definition _table_create3 := 100000354%positive.
Definition _table_destroy3 := 100000355%positive.
Definition _table_map3 := 100000356%positive.
Definition _table_unmap3 := 100000357%positive.
Definition _data_create3 := 100000358%positive.
Definition _data_destroy3 := 100000359%positive.
Definition _smc_rtt_create := 100000360%positive.
Definition _smc_rtt_destroy := 100000361%positive.
Definition _smc_rtt_map := 100000362%positive.
Definition _smc_rtt_unmap := 100000363%positive.
Definition _smc_data_create := 100000364%positive.
Definition _smc_data_destroy := 100000365%positive.
Definition _handle_ns_smc := 100000366%positive.
Definition _rmm_handler := 100000367%positive.
Definition _realm_ns_step := 100000368%positive.

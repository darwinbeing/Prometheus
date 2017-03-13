// ----------------------------------------------------------------------------
//
// ----------------------------------------------------------------------------
// FILE NAME      : core_unit_base_test.sv
// PROJECT        : Prometheus
// AUTHOR         : Grigoriy Zhiharev
// AUTHOR'S EMAIL : gregory.zhiharev@gmail.com
// ----------------------------------------------------------------------------
// DESCRIPTION    :
// ----------------------------------------------------------------------------
`ifndef INC_CORE_UNIT_BASE_TEST
`define INC_CORE_UNIT_BASE_TEST

class core_unit_base_test extends uvm_test;

  core_unit_env_cfg cfg;
  core_unit_env env;
  bit test_pass;

  `uvm_component_utils(core_unit_base_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = core_unit_env::type_id::create("env", this);
    cfg = core_unit_env_cfg::type_id::create("cfg");
    cfg.enable_all_agents();
    cfg.build();
    uvm_config_db#(core_unit_env_cfg)::set(this, "env", "cfg", cfg);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.phase_done.set_drain_time(this, 1000);
  endtask

  function void extract_phase(uvm_phase phase);
      uvm_report_server srvr = uvm_report_server::get_server();
      test_pass = (srvr.get_severity_count(UVM_ERROR) == 0) && (srvr.get_severity_count(UVM_FATAL) == 0);
  endfunction

  function void report_phase(uvm_phase phase);
    if(test_pass) $display("TEST PASSED");
    else $display("TEST FAILED");
  endfunction


endclass
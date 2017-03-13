// ----------------------------------------------------------------------------
//
// ----------------------------------------------------------------------------
// FILE NAME      : core_unit_env.sv
// PROJECT        : Prometheus
// AUTHOR         : Grigoriy Zhiharev
// AUTHOR'S EMAIL : gregory.zhiharev@gmail.com
// ----------------------------------------------------------------------------
// DESCRIPTION    :
// ----------------------------------------------------------------------------
`ifndef INC_CORE_UNIT_ENV
`define INC_CORE_UNIT_ENV

class core_unit_env extends uvm_env;

  core_unit_env_cfg cfg;

  clk_vc_agent      clk_agent;
  rst_vc_agent      rst_agent;
  irq_vc_agent      irq_agent;
  core_slave_agent  core_instr_agent;
  core_slave_agent  core_data_agent;

  `uvm_component_utils(core_unit_env)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(core_unit_env_cfg)::get(this, "", "cfg", cfg))
      `uvm_fatal("NOCFG", $sformatf("Configuration must be set for %s.cfg", get_full_name()))
    end
    if(cfg.has_clk_agent) begin
      clk_agent = clk_vc_agent::type_id::create("clk_agent", this);
      uvm_config_db#(clk_vc_agent_cfg)::set(this, "clk_agent", "cfg", cfg.clk_agent_cfg);
    end
    if(cfg.has_rst_agent) begin
      rst_agent = rst_vc_agent::type_id::create("rst_agent", this);
      uvm_config_db#(rst_vc_agent_cfg)::set(this, "rst_agent", "cfg", cfg.rst_agent_cfg);
    end
    if(cfg.has_irq_agent) begin
      irq_agent = irq_vc_agent::type_id::create("irq_agent", this);
      uvm_config_db#(irq_vc_agent_cfg)::set(this, "irq_agent", "cfg", cfg.irq_agent_cfg);
    end
    if(cfg.has_core_instr_agent) begin
      core_instr_agent = core_slave_agent::type_id::create("core_instr_agent", this);
      uvm_config_db#(core_instr_agent_cfg)::set(this, "core_instr_agent", "cfg", cfg.core_instr_agent_cfg);
    end
    if(cfg.has_core_data_agent) begin
      core_data_agent = core_slave_agent::type_id::create("core_data_agent", this);
      uvm_config_db#(core_data_agent_cfg)::set(this, "core_data_agent", "cfg", cfg.core_data_agent_cfg);
    end
  endfunction

  function void connect_phase(uvm_phase phase);
  	super.connect_phase(phase);
  endfunction

endclass

`endif
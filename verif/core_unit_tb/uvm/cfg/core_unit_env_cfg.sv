// ----------------------------------------------------------------------------
//
// ----------------------------------------------------------------------------
// FILE NAME      : core_unit_env_cfg.sv
// PROJECT        : Prometheus
// AUTHOR         : Grigoriy Zhiharev
// AUTHOR'S EMAIL : gregory.zhiharev@gmail.com
// ----------------------------------------------------------------------------
// DESCRIPTION    :
// ----------------------------------------------------------------------------
`ifndef INC_CORE_UNIT_ENV_CFG
`define INC_CORE_UNIT_ENV_CFG

class core_unit_env_cfg extends uvm_object;

  bit has_clk_agent;
  bit has_rst_agent;
  bit has_irq_agent;
  bit has_core_instr_agent;
  bit has_core_data_agent;

  clk_vc_agent_cfg      clk_agent_cfg;
  rst_vc_agent_cfg      rst_agent_cfg;
  irq_vc_agent_cfg      irq_agent_cfg;
  core_slave_agent_cfg  core_instr_agent_cfg;
  core_slave_agent_cfg  core_data_agent_cfg;

  `uvm_component_utils(core_unit_env_cfg)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void enable_all_agents();
    has_clk_agent = 1;
    has_rst_agent = 1;
    has_irq_agent = 1;
    has_core_instr_agent = 1;
    has_core_data_agent  = 1;
  endfunction

  function void build();
    if(has_clk_agent) begin
      clk_agent_cfg = clk_vc_agent_cfg::type_id::create("clk_agent_cfg");
    end
    if(has_rst_agent) begin
      rst_agent_cfg = rst_vc_agent_cfg::type_id::create("rst_agent_cfg");
    end
    if(has_irq_agent) begin
      irq_agent_cfg = irq_vc_agent_cfg::type_id::create("irq_agent_cfg");
    end
    if(has_core_instr_agent) begin
      core_instr_agent_cfg = core_slave_agent_cfg::type_id::create("core_instr_agent_cfg");
    end
    if(has_core_data_agent) begin
      core_data_agent_cfg = core_slave_agent::type_id::create("core_data_agent_cfg");
    end
  endfunction

endclass

`endif
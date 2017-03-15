// ----------------------------------------------------------------------------
//
// ----------------------------------------------------------------------------
// FILE NAME      : core_agent_cfg.sv
// PROJECT        : Prometheus
// AUTHOR         : Grigoriy Zhiharev
// AUTHOR'S EMAIL : gregory.zhiharev@gmail.com
// ----------------------------------------------------------------------------
// DESCRIPTION    :
// ----------------------------------------------------------------------------

`ifndef INC_CORE_AGENT_CFG
`define INC_CORE_AGENT_CFG

class core_agent_cfg extends uvm_object;

	bit is_active = 1;
	bit has_check = 1;
	bit has_cov   = 0;

	int rdata_width;
	int addr_width;

	`uvm_object_utils_begin(core_agent_cfg)
		`uvm_field_object(is_active, UVM_DEFAULT)
	`uvm_object_utils_end

  function new(string name = "core_agent_cfg");
    super.new(name);
  endfunction

endclass

`endif
// ----------------------------------------------------------------------------
//
// ----------------------------------------------------------------------------
// FILE NAME      : core_slave_agent_cfg.sv
// PROJECT        : Prometheus
// AUTHOR         : Grigoriy Zhiharev
// AUTHOR'S EMAIL : gregory.zhiharev@gmail.com
// ----------------------------------------------------------------------------
// DESCRIPTION    :
// ----------------------------------------------------------------------------

`ifndef INC_CORE_SLAVE_AGENT_CFG
`define INC_CORE_SLAVE_AGENT_CFG

class core_slave_agent_cfg extends core_agent_cfg;

	bit gnt_default_value;
	bit rvalid_default_value;

	`uvm_object_utils_begin(core_slave_agent_cfg)
		`uvm_field_int(gnt_default_value, 		UVM_DEFAULT)
		`uvm_field_int(rvalid_default_value, 	UVM_DEFAULT)
	`uvm_object_utils_end

  function new(string name = "core_slave_agent_cfg");
    super.new(name);
  endfunction

endclass

`endif
// ----------------------------------------------------------------------------
//
// ----------------------------------------------------------------------------
// FILE NAME      : core_bus_item.sv
// PROJECT        : Prometheus
// AUTHOR         : Grigoriy Zhiharev
// AUTHOR'S EMAIL : gregory.zhiharev@gmail.com
// ----------------------------------------------------------------------------
// DESCRIPTION    :
// ----------------------------------------------------------------------------
`ifndef INC_CORE_BUS_ITEM
`define INC_CORE_BUS_ITEM

class core_bus_item extends uvm_sequence_item;

	// Performance
	longint req_asserted_time;
	longint req_accepted_time;
	longint req_finished_time;

	// Dealys
	int gnt_delay;
	int rvalid_delay;
	int max_num_outstanding_req;

  `uvm_object_utils_begin(core_bus_item)
  `uvm_object_utils_end

  function new(string name = "");
    super.new(name);
  endfunction


endclass

`endif
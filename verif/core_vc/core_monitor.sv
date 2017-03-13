// ----------------------------------------------------------------------------
//
// ----------------------------------------------------------------------------
// FILE NAME      : core_monitor.sv
// PROJECT        : Prometheus
// AUTHOR         : Grigoriy Zhiharev
// AUTHOR'S EMAIL : gregory.zhiharev@gmail.com
// ----------------------------------------------------------------------------
// DESCRIPTION    :
// ----------------------------------------------------------------------------
`ifndef INC_CORE_MONITOR
`define INC_CORE_MONITOR

class core_monitor extends uvm_monitor;

  virtual core_if vif;

  uvm_analysis_port#(core_bus_item) item_collected_port;

  protected uvm_queue #(core_bus_item) req_q;
  protected core_bus_state bus_state;
  protected core_bus_item  req;

  `uvm_component_utils(core_monitor)

  function new (string name, uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
    req_q = new("req_q");
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    monitor_bus();
  endtask

  function void reset();
    req_q = new("req_q");
    bus_state = IDLE;
  endfunction

  task monitor_bus();
    forever begin
    	@(vif.mon);
      if(!vif.rst) begin
      	process_bus_req();
      	process_bus_rsp();
      end
      else begin
      	reset();
      end
    end
  endtask

  function void process_bus_req();
    case(bus_state)
      IDLE: begin
      	if(vif.mon.req) begin
      		req.begin_tr();
      		req.req_asserted_time = $time();
      		req.addr = vif.mon.addr;
      		req.we = vif.mon.we;
      		req.be = vif.mon.be;
      		req.wdata = vif.mon.wdata;
      		bus_state = WAIT_FOR_GRANT;
      	end
      end
      WAIT_FOR_GRANT: begin
      	if(vif.mon.gnt) begin
      		req.req_accepted_time = $time();
      		req_q.push_back(req);
      		bus_state = IDLE;
      	end
      end
      default: `uvm_fatal(get_full_name(), "Wrong state!")
     endcase
  endfunction

  function void process_bus_rsp();
  	if(req_q.size() != 0 && vif.mon.rvalid) begin
  	core_bus_item item = req_q.pop_front();
  	item.req_finished_time = $time();
  	item.rdata = vif.mon.rdata;
  	item_collected_port.write(item);
  endfunction

endclass

`endif
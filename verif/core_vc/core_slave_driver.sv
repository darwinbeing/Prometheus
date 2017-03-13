// ----------------------------------------------------------------------------
//
// ----------------------------------------------------------------------------
// FILE NAME      : core_slave_driver.sv
// PROJECT        : Prometheus
// AUTHOR         : Grigoriy Zhiharev
// AUTHOR'S EMAIL : gregory.zhiharev@gmail.com
// ----------------------------------------------------------------------------
// DESCRIPTION    :
// ----------------------------------------------------------------------------

`ifndef INC_CORE_SLAVE_DRIVER
`define INC_CORE_SLAVE_DRIVER

class core_slave_driver extends uvm_driver #(core_bus_item);

  virtual core_if vif;
  core_slave_agent_cfg cfg;

  protected core_bus_state gnt_bus_state;
  protected core_bus_state rsp_bus_state;
  protected uvm_queue #(core_bus_item) outstanding_req_q;


  `uvm_component_utils(core_slave_driver)

  function new (string name, uvm_component parent);
    super.new(name, parent);
    outstanding_req_q = new("outstanding_req_q");
    gnt_bus_state = IDLE;
    rsp_bus_state = IDLE;
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void do_gnt_item(ref core_bus_item item);
  	if(item.gnt_delay == 0) begin
    	core_bus_item ret_item;
      assert($cast(ret_item, item.clone()));
      ret_item.set_id_info(item);
      ret_item.accept_tr();
      vif.drv_s.gnt <= 1'b1;
      outstanding_req_q.push_back(ret_item);
      seq_item_port.item_done();
      seq_item_port.put_response(ret_item);
      gnt_bus_state = IDLE;
    end
    else begin
    	vif.drv_s.gnt <= 1'b0;
      item.gnt_delay--;
      gnt_bus_state = WAIT_FOR_GRANT;
    end
  endfunction

  function void do_rsp_item(ref core_bus_item item);
  	if(rsp_item.rvalid_delay == 0) begin
      vif.drv_s.rvalid <= 1'b1;
      vif.drv_s.rdata  <= rsp_item.data;
      rsp_bus_state = IDLE;
    end
    else begin
    	vif.drv_s.rvalid <= 1'b0;
      rsp_item.rvalid_delay--;
      rsp_bus_state = DELAY;
    end
  endfunction

  function void reset_interface();
  	vif.drv_s.gnt    <= 1'b0;
  	vif.drv_s.rvalid <= 1'b0;
  	vif.drv_s.rdata  <= `CORE_DATA_WIDTH'h0;
  endfunction

  task run_phase(uvm_phase phase);
  	core_bus_item gnt_item;
  	core_bus_item rsp_item;
    forever begin
      @(vif.drv_s);
      if(!vif.rst) begin
      	case(bus_state)
      		IDLE: begin
        		if(vif.drv_s.req_val) begin
        			if(outstanding_req_q.size() < cfg.max_num_outstanding_req) begin
            		seq_item_port.try_next_item(gnt_item);
            		if(gnt_item != null) begin
            			do_gnt_item(gnt_item);
              	end
              	else
              		vif.drv_s.gnt <= 1'b0;
           				bus_state = IDLE;
           			end
           		end
           		else begin
                vif.drv_s.gnt <= 1'b0;
              	bus_state = WAIT_FOR_GRANT;
           		end
         		end
         		else begin
         			bus_state = IDLE;
         			// random gnt?
         		end
         	end
         	WAIT_FOR_GRANT: begin
         		do_gnt_item(gnt_item);
        	end
      	endcase
      	case(rsp_bus_state)
      		IDLE: begin
      			if(outstanding_req_q.size() != 0) begin
      				assert($cast(rsp_item, outstanding_req_q.pop_front()))
      				else `uvm_fatal(get_full_name(), "Cast failed!")
 							rsp_bus_state = WAIT_FOR_GRANT;
      			end
      		end
      		WAIT_FOR_GRANT: begin
      			do_rsp_item(rsp_item);
      		end
      	endcase
      end
      else begin
      	reset_interface();
      end
    end
  endtask

endclass

`endif
// ----------------------------------------------------------------------------
//
// ----------------------------------------------------------------------------
// FILE NAME      : core_slave_agent.sv
// PROJECT        : Prometheus
// AUTHOR         : Grigoriy Zhiharev
// AUTHOR'S EMAIL : gregory.zhiharev@gmail.com
// ----------------------------------------------------------------------------
// DESCRIPTION    :
// ----------------------------------------------------------------------------

`ifndef CORE_SLAVE_AGENT_INC
`define CORE_SLAVE_AGENT_INC

class core_slave_agent extends uvm_agent;

	core_sequencer     		sequencer;
  core_monitor       		monitor;
	core_slave_driver  		driver;
  core_slave_agent_cfg 	cfg;

  uvm_analysis_port #(core_bus_item)  item_collected_port;

	`uvm_component_utils(core_slave_agent)

  function new (string name, uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
  endfunction

 	function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(core_slave_agent_cfg)::get(this, "", "cfg", cfg))
    	`uvm_fatal("NOCFG", $sformatf("Configuration must be set for %s.cfg", get_full_name()))
    if(cfg.vif == null) begin
    	if(!uvm_config_db#(virtual core_if)::get(this, "", "vif",cfg.vif))
    		`uvm_fatal("NOVIF", $sformatf("Virtual interfce must be set for %s.cfg.vif", get_full_name()))
    end
    if(cfg.is_active) begin
      driver = core_slave_driver::type_id::create("driver", this);
      sequencer = core_sequencer::type_id::create("sequencer", this);
    end
    monitor = core_monitor::type_id::create("monitor", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(cfg.is_active) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
      driver.vif = cfg.vif;
    end
    monitor.item_collected_port.connect(item_collected_port);
    monitor.vif = cfg.vif;
  endfunction
endclass

`endif
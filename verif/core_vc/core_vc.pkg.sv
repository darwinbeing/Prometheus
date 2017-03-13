// ----------------------------------------------------------------------------
//
// ----------------------------------------------------------------------------
// FILE NAME      : core_vc.pkg.sv
// PROJECT        : Prometheus
// AUTHOR         : Grigoriy Zhiharev
// AUTHOR'S EMAIL : gregory.zhiharev@gmail.com
// ----------------------------------------------------------------------------
// DESCRIPTION    :
// ----------------------------------------------------------------------------

`include "core_defines.svh"
`include "core_if.sv"

package core_vc_pkg;

	typedef enum int {INSTR, DATA} core_if_enum;

	typedef enum int {IDLE, WAIT_FOR_GNT, WAIT_FOR_RSP} core_bus_state;

	`include "core_bus_item.sv"
	`include "core_agent_cfg.sv"
	`include "core_master_agent_cfg.sv"
	`include "core_slave_agent_cfg.sv"
	`include "core_monitor.sv"
	`include "core_master_driver.sv"
	`include "core_slave_driver.sv"
endpackage
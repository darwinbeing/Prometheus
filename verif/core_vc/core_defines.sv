// ----------------------------------------------------------------------------
//
// ----------------------------------------------------------------------------
// FILE NAME      : core_defines.sv
// PROJECT        : Prometheus
// AUTHOR         : Grigoriy Zhiharev
// AUTHOR'S EMAIL : gregory.zhiharev@gmail.com
// ----------------------------------------------------------------------------
// DESCRIPTION    :
// ----------------------------------------------------------------------------
`ifndef INC_CORE_DEFINES
`define INC_CORE_DEFINES

`ifndef CORE_SKEW_IN
	`define CORE_SKEW_IN 0ns
`endif

`ifndef CORE_SKEW_OUT
	`define CORE_SKEW_OUT 0ns
`endif

`ifndef CORE_CLK_DELAY
	`define CORE_CLK_DELAY 1ps
`endif

`ifndef CORE_ADDR_WIDTH
	`define CORE_ADDR_WIDTH 32
`endif

`ifndef CORE_DATA_WIDTH
	`define CORE_DATA_WIDTH 32
`endif

`define CORE_BE_WIDTH (`CORE_DATA_WIDTH / 4)

`endif
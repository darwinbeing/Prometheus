// ----------------------------------------------------------------------------
//
// ----------------------------------------------------------------------------
// FILE NAME      : core_if.sv
// PROJECT        : Prometheus
// AUTHOR         : Grigoriy Zhiharev
// AUTHOR'S EMAIL : gregory.zhiharev@gmail.com
// ----------------------------------------------------------------------------
// DESCRIPTION    :
// ----------------------------------------------------------------------------

`ifndef CORE_IF_INC
`define CORE_IF_INC

interface core_if(input wire clk, input wire rst);
	logic 											req;
	logic [`CORE_ADDR_WIDTH:0] 	addr;
	logic  											we;
	logic [`CORE_BE_WIDTH:0]    be;
	logic         							gnt;
	logic         							rvalid;
	logic [`CORE_DATA_WIDTH:0] 	wdata;
	logic [`CORE_DATA_WIDTH:0] 	rdata;

	logic drv_clk;

	always  #`CORE_CLK_DELAY drv_clk = clk;

	clocking mon @(posedge clk);
		input req;
		input addr;
		input we;
		input be;
		input gnt;
		input rvalid;
		input wdata;
		input rdata;
	endclocking

	clocking drv_m @(posedge drv_clk);
		default input #`CORE_SKEW_IN; default output #`CORE_SKEW_OUT;
		output req;
		output addr;
		output we;
		output be;
		output wdata;
		input  gnt;
		input  rvalid;
		input  rdata;
	endclocking

	clocking drv_s @(posedge drv_clk);
		default input #`CORE_SKEW_IN; default output #`CORE_SKEW_OUT;
		output gnt;
		output rvalid;
		output rdata;
		input  req;
		input  addr;
		input  we;
		input  be;
		input  wdata;
	endclocking

	// 1 Signal assertions

	// 1.1 No X on addr when req and not rst
	// 1.2 No X on we when req and not rst
	// 1.3 No X on wdata when req and not rst
	// 1.4 No X on be when req and not rst
	// 1.5 No X on rdata when rvalid and not rst

	// 2 Protocol assertions

	// 2.1 addr remains stable after req is high and before gnt is high
	//     As soon as gnt is high, the next cycle addr may change
	// 2.2 we remains stable after req is high and before gnt is high
	//     As soon as gnt is high, the next cycle we may change
	// 2.3 be remains stable after req is high and before gnt is high
	//     As soon as gnt is high, the next cycle be may change
	// 2.4 wdata remains stable after req is high and before gnt is high
	//     As soon as gnt is high, the next cycle wdata may change
	// 2.5 rvalid must be asserted one or more cycles after gnt was received

endinterface
`endif
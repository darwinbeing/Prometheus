`ifndef INC_ENV_PKG
`define INC_ENV_PKG

`include "core_vc.pkg.sv"

package env_pkg;
	import uvm_pkg::*;
	import core_vc_pkg::*;

	`include "cfg/core_unit_env_cfg.sv"
	`include "environment/core_unit_env.sv"
	`include "tests/core_unit_base_test.sv"

endpackage

`endif

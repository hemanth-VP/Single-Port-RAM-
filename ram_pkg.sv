
//This package includes all the files in the testbench architecture 
//which will be imported in the top module
package ram_pkg;
  `include "ram_transaction.sv"
  `include "ram_generator.sv"
  `include "ram_driver.sv"
  `include "ram_monitor.sv"
  `include "ram_reference_model.sv"
  `include "ram_scoreboard.sv"
  `include "ram_environment.sv"
  `include "ram_test.sv"
endpackage

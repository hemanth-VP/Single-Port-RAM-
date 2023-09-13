`include "defines.sv"
class ram_monitor;
//PROPERTIES
  //Ram transaction class handle
    ram_transaction mon_trans;
  //Mailbox for monitor to scoreboard connection
    mailbox #(ram_transaction) mbx_ms;
  //Virtual interface with driver modport and it's instance 
    virtual ram_if.MON vif;

//FUNCTIONAL COVERAGE for outputs
  covergroup mon_cg;
    DATA_OUT: coverpoint mon_trans.data_out {bins  dout[] ={[0:255]};}
  endgroup

//METHODS
  //Explicitly overriding the constructor to make mailbox connection from monitor
  //to scoreboard, to make mailbox connection from monitor to scoreboard and
  //to connect the virtual interface from monitor to enviornment 
  function new( virtual ram_if.MON vif,
                mailbox #(ram_transaction) mbx_ms);
    this.vif=vif;
    this.mbx_ms=mbx_ms;
   //Creating the object for covergroup
    mon_cg=new();
  endfunction

  //Task to collect the output from the interface
  task start();
   repeat(4) @(vif.mon_cb); 
    for(int i=0;i<`no_of_trans;i++)
      begin
        mon_trans=new();
        repeat(1) @(vif.mon_cb)
             begin
              mon_trans.data_out=vif.mon_cb.data_out;
              mon_trans.address=vif.mon_cb.address;
             end
        $display("MONITOR PASSING THE DATA TO SCOREBOARD data_out=%d",mon_trans.data_out,$time);
        //Putting the collected ouputs to mailbox    
        mbx_ms.put(mon_trans);
        //Sampling the covergroup
        mon_cg.sample();
        $display("OUTPUT FUNCTIONAL COVERAGE = %0d", mon_cg.get_coverage());
        repeat(1) @(vif.mon_cb);
      end
  endtask
endclass      






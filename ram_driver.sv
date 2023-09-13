`include "defines.sv"
class ram_driver;
//PROPERTIES  
  //Ram transaction class handle
   ram_transaction drv_trans;
  //Mailbox for generator to driver connection
   mailbox #(ram_transaction)mbx_gd;
  //Mailbox for driver to reference model connection
   mailbox #(ram_transaction)mbx_dr;
  //Virtual interface with driver modport and it's instance 
   virtual ram_if.DRV vif;

//FUNCTIONAL COVERAGE for inputs
covergroup drv_cg;
  WRITE:   coverpoint drv_trans.write_enb { bins wrt[]={0,1};}
  READ :   coverpoint drv_trans.read_enb  { bins  rd[]={0,1};}
  DATA_IN: coverpoint drv_trans.data_in   { bins data ={[0:255]};}
  ADDRESS: coverpoint drv_trans.address   { bins address={[0:31]};}
  WRXRD:   cross WRITE,READ;
endgroup
 
//METHODS
  //Explicitly overriding the constructor to make mailbox connection from driver
  //to generator, to make mailbox connection from driver to reference model and
  //to connect the virtual interface from driver to enviornment 
  function new(mailbox #(ram_transaction)mbx_gd,
               mailbox #(ram_transaction)mbx_dr,
               virtual ram_if.DRV vif);
    this.mbx_gd=mbx_gd;
    this.mbx_dr=mbx_dr;
    this.vif=vif;
   //Creating the object for covergroup
    drv_cg=new();
  endfunction

  //Task to drive the stimuli to the interface
  task start();
    repeat(3) @(vif.drv_cb);
    for(int i=0;i<`no_of_trans;i++)
      begin
        drv_trans=new();
       //Getting the transaction from generator
        mbx_gd.get(drv_trans);
        if(vif.drv_cb.reset==0)
         repeat(1) @(vif.drv_cb)
          begin
           vif.drv_cb.write_enb<=0;
           vif.drv_cb.read_enb<=0;
           vif.drv_cb.data_in<=8'bz;  
           vif.drv_cb.address<=0;
           mbx_dr.put(drv_trans);
           repeat(1) @(vif.drv_cb);          
           $display("DRIVER DRIVING DATA TO THE INTERFACE data_in=%d,write_enb=%d,read_enb=%d,address=%d",vif.drv_cb.data_in,vif.drv_cb.write_enb,vif.drv_cb.read_enb,vif.drv_cb.address,$time);
          end
        else
         repeat(1) @(vif.drv_cb)
          begin
               vif.drv_cb.write_enb<=drv_trans.write_enb;
               vif.drv_cb.read_enb<=drv_trans.read_enb;
               vif.drv_cb.data_in<=drv_trans.data_in;  
               vif.drv_cb.address<=drv_trans.address;
               repeat(1) @(vif.drv_cb);
               $display("DRIVER WRITE OPERATION DRIVING DATA TO THE INTERFACE data_in=%d,write_enb=%d,read_enb=%d,address=%d",vif.drv_cb.data_in,vif.drv_cb.write_enb,vif.drv_cb.read_enb,vif.drv_cb.address,$time); 
               vif.drv_cb.write_enb<=0;
               //Putting the randomized inputs to mailbox    
               mbx_dr.put(drv_trans);
               //Sampling the covergroup
               drv_cg.sample();
               $display("INPUT FUNCTIONAL COVERAGE = %0d", drv_cg.get_coverage());
        end
     end
  endtask
endclass


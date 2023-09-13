
`include "defines.sv"
class ram_generator;
//PROPERTIES
  //Ram transaction class handle 
  ram_transaction  blueprint;
  //Mailbox for generator to driver connection
  mailbox #(ram_transaction)mbx_gd;

//METHODS
  //Explicitly overriding the constructor to make mailbox connection 
  //from generator to driver
  function new(mailbox #(ram_transaction)mbx_gd);
    this.mbx_gd=mbx_gd;
    blueprint=new();
  endfunction

  //Task to generate the random stimuli
  task start();
    for(int i=0;i<`no_of_trans;i++)
      begin
      //Randomizing the inputs
        blueprint.randomize();
      //Putting the randomized inputs to mailbox    
        mbx_gd.put(blueprint.copy());  
        $display("GENERATOR Randomized transaction data_in=%d,write_enb=%d,read_enb=%d,address=%d",
                  blueprint.data_in,blueprint.write_enb,blueprint.read_enb,blueprint.address,$time);
      end
  endtask
endclass

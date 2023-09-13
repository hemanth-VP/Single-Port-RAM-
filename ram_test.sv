class ram_test;
//PROPERTIES
  //Virtual interfaces for driver, monitor and reference model
  virtual ram_if drv_vif;
  virtual ram_if mon_vif;
  virtual ram_if ref_vif;
  //Declaring handle for environment
  ram_environment env;

//METHODS
  //Explicitly overriding the constructor to connect the virtual interfaces
  //from driver, monitor and reference model to test
  function new(virtual ram_if drv_vif,
               virtual ram_if mon_vif,
               virtual ram_if ref_vif);
    this.drv_vif=drv_vif;
    this.mon_vif=mon_vif;
    this.ref_vif=ref_vif;
  endfunction

  //Task which builds the object for environment handle and 
  //calls the build and start methods of the environment
  task run();
    env=new(drv_vif,mon_vif,ref_vif);
    env.build;
    env.start;
  endtask
endclass
/////////////////////////////////////////////////////////////////////////////
/*class test1 extends test;
 ram_transaction1 trans;
  function new(virtual ram_if drv_vif,virtual ram_if mon_vif);
    super.new(drv_vif,mon_vif);
  endfunction

  task run();
    env=new(drv_vif,mon_vif);
    env.build;
    begin 
    trans = new();
    env.gen.blueprint= trans;
    end
    env.start;
  endtask
endclass

class test2 extends test;
 ram_transaction2 trans;
  function new(virtual ram_if drv_vif,virtual ram_if mon_vif);
    super.new(drv_vif,mon_vif);
  endfunction

  task run();
    $display("child test");
    env=new(drv_vif,mon_vif);
    env.build;
    begin 
    trans = new();
    env.gen.blueprint= trans;
    end
    env.start;
  endtask
endclass

class test3 extends test;
 ram_transaction3 trans;
  function new(virtual ram_if drv_vif,virtual ram_if mon_vif);
    super.new(drv_vif,mon_vif);
  endfunction

  task run();
    $display("child test");
    env=new(drv_vif,mon_vif);
    env.build;
    begin 
    trans = new();
    env.gen.blueprint= trans;
    end
    env.start;
  endtask
endclass

class test4 extends test;
 ram_transaction4 trans;
  function new(virtual ram_if drv_vif,virtual ram_if mon_vif);
    super.new(drv_vif,mon_vif);
  endfunction

  task run();
   // $display("child test");
    env=new(drv_vif,mon_vif);
    env.build;
    begin 
    trans = new();
    env.gen.blueprint= trans;
    end
    env.start;
  endtask
endclass


class test_regression extends ram_test;
 ram_transaction  trans0;
 ram_transaction1 trans1;
// ram_transaction2 trans2;
// ram_transaction3 trans3;
// ram_transaction4 trans4;
  function new(virtual ram_if drv_vif,
               virtual ram_if mon_vif,
               virtual ram_if ref_vif);
    super.new(drv_vif,mon_vif,ref_vif);
  endfunction

  task run();
    //$display("child test");
    env=new(drv_vif,mon_vif,ref_vif);
    env.build;
///////////////////////////////////////////////////////
    begin 
    trans0 = new();
    env.gen.blueprint= trans0;
    end
    env.start;
//////////////////////////////////////////////////////

///////////////////////////////////////////////////////
    begin 
    trans1 = new();
    env.gen.blueprint= trans1;
    end
    env.start;
//////////////////////////////////////////////////////

///////////////////////////////////////////////////////
    begin 
    trans2 = new();
    env.gen.blueprint= trans2;
    end
    env.start;
//////////////////////////////////////////////////////

///////////////////////////////////////////////////////
    begin 
    trans3 = new();
    env.gen.blueprint= trans3;
    end
    env.start;
//////////////////////////////////////////////////////

///////////////////////////////////////////////////////
    begin 
    trans4 = new();
    env.gen.blueprint= trans4;
    end
    env.start;
//////////////////////////////////////////////////////
  endtask
endclass
*/



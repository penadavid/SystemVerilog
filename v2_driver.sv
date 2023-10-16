`ifndef DRIVER_SV
 `define DRIVER_SV

class driver;

   newTransaction tr;
   

   virtual memory_if mem_if;
   
   monitor m;

   function new(virtual memory_if mem_if);
      this.mem_if = mem_if;
   endfunction : new

   task run();
      tr = new();
      tr.addr = 2'h0;
      tr.en = 1'b0;
      tr.rw = 1'b0;
      drive_transaction(tr);
      m.monitoring(tr);
      tr.addr = 2'hA;
      tr.en = 1'b1;
      tr.data_i = 8'hAA;
      tr.rw = 1'b1;
      drive_transaction(tr);
      m.monitoring(tr);
      tr.rw = 1'b0;
      tr.en = 1'b1;
      drive_transaction(tr);
      m.monitoring(tr);
      tr.en = 1'b0;
      drive_transaction(tr);
      m.monitoring(tr);
      m.ispis();
   endtask : run

   task drive_transaction(newTransaction tr);
      $display("Driving transaction:");
      tr.display_transaction();
      @(posedge mem_if.clk);
      mem_if.addr <= tr.addr;
      mem_if.data_i <= tr.data_i;
      //mem_if.data_o <= tr.data_o;
      mem_if.en <= tr.en;
      mem_if.rw <= tr.rw;
   endtask : drive_transaction

endclass : driver

`endif

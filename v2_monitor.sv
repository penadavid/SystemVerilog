`ifndef MONITOR_SV
 `define MONITOR_SV
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2023 08:39:17 AM
// Design Name: 
// Module Name: v2_monitor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


class monitor;

    
    static int ispravneTransakcije[$];
    newTransaction tr;
    
    
   // virtual memory_if mem_if;
    
    /*function new(virtual memory_if mem_if);
          this.mem_if = mem_if;
     endfunction : new
     */  
    task monitoring(newTransaction tr);
    $display("Monitoring:");
    if( tr.en == 1'b1) begin
        if(tr.rw == 1'b1) begin
            ispravneTransakcije.push_back(tr.data_i);
            $display("ispravna transakcija - UPIS-> %0h", tr.data_i);
        end
        else begin
            ispravneTransakcije.push_back(tr.data_o);
            $display("ispravna transakcija - CITANJE-> %0h", tr.data_o);
        end
    end
    else 
        $display("NEISPRAVNA TRANSAKCIJA!");
    endtask : monitoring
    
    static task ispis();
    $display("ispravne transakcije su -> %0p", ispravneTransakcije);
    endtask : ispis
        
endclass : monitor

`endif;

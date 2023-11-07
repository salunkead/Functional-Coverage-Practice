///covering a coverpoint using function call
module test;
  typedef enum bit{busy,quit}state;
  state s;
  bit clk;
  always #5 clk=!clk;
  
  function state Cpoint_state(bit valid,ready);
        if(!valid) return quit;
        if(valid&& ~ready) return busy;
  endfunction
  
  covergroup cg(input bit valid,ready)@(posedge clk);
    option.per_instance=1;
    coverpoint s{
      bins st[]={Cpoint_state(valid,ready)};
    }
  endgroup
  
  initial
    begin
      cg c;
      c=new(1,0);
      c=new(0,0);
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule

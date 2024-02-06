//Non-consecutive repeatation 
module test;
  bit clk,state;
  always #5 clk=!clk;
  
  covergroup cg@(posedge clk);
    option.per_instance=1;
    option.comment="Non-consecutive Repeatation";
    coverpoint state{
      bins trans=(0=>1[->3]=>0); //0 then in next clock cycle state value should be 1 for non-consecutive cycle the in next clock,it should become 0
    }
  endgroup
  
  initial
    begin
      cg c1=new;
      repeat(30)
        begin
          @(negedge clk);
          state=$random;
        end
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #300 $finish;
    end
endmodule

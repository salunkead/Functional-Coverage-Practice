////ignore bins
//ignored bins are not considered for coverage calculation
module test;
  bit clk;
  bit [3:0]state;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    option.comment="ignore bins";
    coverpoint state{
      ignore_bins ig1={4,2}; 
      ignore_bins ig2={[10:$]};
    }
  endgroup
  initial
    begin
      cg c=new;
      repeat(60)
        begin
          @(negedge clk);
          state=$urandom;
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #600 $finish;
    end
endmodule

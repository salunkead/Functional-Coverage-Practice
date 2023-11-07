///transition coverage
module test;
  bit [1:0]state;
  bit clk;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    option.name="state transition coverage";
    option.comment="transistion coverage";
    coverpoint state{
      bins s0tos1=(0=>1);
      bins s1tos2=(1=>2);
      bins s2tos3=(2=>3);
    }
  endgroup
  
  initial
    begin
      cg c=new;
      repeat(50)
        begin
          state=$urandom;
          @(posedge clk);
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #500 $finish;
    end
endmodule

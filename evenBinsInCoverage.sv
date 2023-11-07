//how to get even numbers in coverage
module test;
  bit [3:0]x;
  bit clk;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    x_c:coverpoint x{
      bins even[]=x_c with (item%2==0);
    }
  endgroup
  initial
    begin                                                                                                                                               
      cg c=new;
      repeat(100)
        begin
          @(posedge clk);
          x=$urandom;
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #800 $finish;
    end
endmodule

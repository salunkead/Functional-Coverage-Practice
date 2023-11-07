//using an expression in coverpoint
module test;
  bit[4:0]b1,b2,b3;
  bit clk;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    b1b2:coverpoint b1+b2; ///value covered will be the addition of b1 and b2
  endgroup
  initial
    begin                                                                                                                                               
      cg c=new;
        begin
          @(posedge clk);
          b1=10;
          b2=5;
          $display("b1=%0d and b2=%0d --> b1+b2=%0d",b1,b2,b1+b2);
          @(posedge clk);
          b1=6;
          b2=5;
          $display("b1=%0d and b2=%0d --> b1+b2=%0d",b1,b2,b1+b2);
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #50 $finish;
    end
endmodule

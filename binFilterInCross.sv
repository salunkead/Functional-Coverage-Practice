///cross using ignore bins:bins filtering
module test;
  bit [3:0]x,y;
  bit clk;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    x_c:coverpoint x;
    y_c:coverpoint y;
    cross_gt:cross x_c,y_c{
      ignore_bins ignore_gt=cross_gt with (x_c>y_c || x_c==y_c);
    }
  endgroup
  initial
    begin                                                                                                                                               
      cg c=new;
      repeat(100)
        begin
          @(posedge clk);
          {x,y}=$urandom;
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #800 $finish;
    end
endmodule

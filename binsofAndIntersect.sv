///binsof() and intersect()
module test;
  bit clk;
  bit [3:0]num;
  bit [1:0]st;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    option.comment="binsof and intersect";
    cross num,st{
      ignore_bins ig1=binsof(num) intersect{[7:$]};
      ignore_bins ig2=binsof(st) intersect {[2:$]};
    }
  endgroup
  
  initial
    begin
      cg c=new;
      repeat(60)
        begin
          @(negedge clk);
          num=$urandom;
          st=$urandom;
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #600 $finish;
    end
endmodule

module test;
  bit [4:0]addr;
  bit clk,wr;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    cross addr,wr{
      ignore_bins we=binsof(addr) intersect {[25:$]};
      ignore_bins we1=binsof(wr) intersect {0};
    }
  endgroup
  
  initial
    begin
      cg c=new;
      repeat(250)
        begin
          @(negedge clk);
          addr=$urandom;
          wr=$urandom;
        end
    end
  initial
    begin
      $dumpfile("cov.vcd");
      $dumpvars;
      #2000 $finish;
    end
endmodule

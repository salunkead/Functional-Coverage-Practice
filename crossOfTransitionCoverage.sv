/////cross of transistion coverage
module test;
  bit clk;
  bit [3:0]addr;
  bit ctrl;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    option.comment="cross of transistion coverage";
    option.name="cross of transistion coverage";
    coverpoint addr{
      bins fivetosix=(5=>6);
    }
    coverpoint ctrl{
      bins onetozero=(1=>0);
    }
    cross addr,ctrl{
      bins valid_transistions=binsof(addr.fivetosix)&&binsof(ctrl.onetozero);
      ///when five to six transition occures at the same time there should be transition from 1 to 0
    }
  endgroup
  initial
    begin
      cg c=new;
      repeat(50)
        begin
          addr=5;
          ctrl=$random;
          @(posedge clk);
          addr=6;
          ctrl=$random;
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

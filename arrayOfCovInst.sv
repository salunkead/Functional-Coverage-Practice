///array of coverage instance
module test;
  bit [7:0]num;
  bit clk;
  always #5 clk=~clk;
  covergroup cg(int max,min)@(posedge clk);
    option.per_instance=1;
    coverpoint num{
      bins cover1={[max:min]};
    }
  endgroup
  initial
    begin
      cg c[10];
      foreach(c[i])
        begin
          c[i]=new($urandom_range(100,300),$urandom_range(1,99));
          @(posedge clk);
          num=$urandom;
        end
    end
  initial
    begin
      #200 $finish;
    end
endmodule

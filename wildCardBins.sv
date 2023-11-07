//wild card bins
module t;
  bit [3:0]a;
  covergroup cg;
    coverpoint a{
      wildcard bins low={4'b???0}; //? can be anything 0 or 1 but L.S.B bit must 0 
      wildcard bins high={4'b01??}; //3 and 2 bit must be 0 and 1 respectively but 1 and 0th bit can be anything 0 or 1
    }
  endgroup
  initial
    begin
      cg c;
      c=new();
      repeat(30)
        begin
          a=$urandom();
          c.sample();
          $displayb(a);
          #10;
        end
        
    end
  initial
    begin
      $dumpfile("d.vcd");
      $dumpvars;
    end
endmodule

//
////wild card bins
module test;
  bit clk;
  bit [3:0]state;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    option.comment="wildcard bins";
    coverpoint state{
      wildcard bins wd[]={4'b11xx};
      wildcard bins wd1[]=(4'b001x=>4'b11xx);
    }
  endgroup
  initial
    begin
      cg c=new;
      repeat(30)
        begin
          @(negedge clk);
          state=$urandom;
        end
      for(int i=2;i<=3;i++)
        begin
          for(int j=12;j<=15;j++)
            begin
              @(negedge clk);
              state=i;
              $display("i=%0d",i);
              @(negedge clk);
              state=j;
              $display("j=%0d",j);
            end
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #600 $finish;
    end
endmodule


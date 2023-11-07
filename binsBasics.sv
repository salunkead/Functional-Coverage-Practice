///bins-basics
module test;
  bit [7:0]a;
  bit clk;
  always #5 clk=~clk;
  covergroup cg;
    option.name="bins basics";
    option.per_instance=1;
    coverpoint a{
      bins single={[2:10]}; //single bin for 2 to 10 numbers
      bins two[2]={[11:15]}; //two bins two[0]=11,12 and two[1]=13,14,15
      bins three[3]={[20:30]};//three bins three[0]=20,21,22 three[1]=23,24,25 three[2]=26,27,28,29,30
    }
  endgroup
  initial
    begin
      cg c;
      c=new;
        begin
          @(posedge clk);
          a=5;
          c.sample();
           @(posedge clk);
          a=12;
          c.sample();
           @(posedge clk);
          a=14;
          c.sample();
           @(posedge clk);
          a=21;
          c.sample();
           @(posedge clk);
          a=24;
          c.sample();
           @(posedge clk);
          a=27;
          c.sample();
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #200 $finish;
    end
endmodule


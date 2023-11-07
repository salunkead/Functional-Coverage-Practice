///Warnings from bins specification
module test;
  bit [2:0]p1;//0 to 7
  bit signed[2:0]p2;//-4 to 3
  bit clk;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    coverpoint p1{
      bins b1={1,[2:5],[6:10]};//A right bound '10' is out of coverpoint 'p1' range. It will be adjusted to the closest acceptable value '7'
      bins b2={-1};//Value '-1' is used within bins of coverpoint 'p1'. It is out of allowed range and will be ignored.
    }
    coverpoint p2{
      bins b3={1,[2:5],[6:10]};//A right bound '5' is out of coverpoint 'p2' range. It will be adjusted to the closest acceptable value '3'
//An interval '[6:10]' is completely out of coverpoint 'p2' range and will be ignored.
    }
  endgroup
  initial
    begin
      cg c=new;
      repeat(10)
        begin
          p1=$urandom;
          p2=$random;
          $display("p1=%0d and p=%0d",p1,p2);
          @(posedge clk);
        end
    end
  initial
    begin
      #200 $finish;
    end
endmodule

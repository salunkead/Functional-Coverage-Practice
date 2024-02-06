//Declaring transition bins using wildcard bins 
module test;
  bit[1:0]num;
  bit clk;
  always #5 clk=~clk;
  
  covergroup cg@(posedge clk);
    option.per_instance=1;
    coverpoint num{
      wildcard bins trans[]=(2'b0x => 2'b1x); //it covers transitions 2'b00 to 2'b10,00 to 11,01 to 10,01 to 11
    }
  endgroup
  
  initial 
    begin
      cg c1=new;
      repeat(30)
        begin
          @(negedge clk);
          num=$urandom_range(0,3);
        end
      #10;
      $finish;
    end
endmodule

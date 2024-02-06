//cross of transition
module test;
  bit a,clk;
  bit[1:0]num;
  always #5 clk=!clk;
  
  covergroup cg@(posedge clk);
    option.per_instance=1;
    option.comment="cross of transition coverage";
    
    coverpoint num{
      bins zeroTotwo=(2'b00 => 2'b10); //this means that num=0 in current clock cycle and in next clock cycle a=2
    }
    
    coverpoint a{
      bins zeroToOne=(1'b0 => 1'b1); //this means that a=0 in current clock cycle and in next clock cycle a=1
    }
    
    cross num,a;  //this means that num=0,a=0 in current clock cycle and in next clock cycle num=2,a=1
  endgroup
  
  initial
    begin
      cg c1=new;
      @(negedge clk);
      num=0;
      a=0;
      @(negedge clk);
      num=2;
      a=1;
      #10;
      $finish;
    end
endmodule

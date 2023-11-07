//reusable covergroup
module t;
  bit [3:0]a,b;
  covergroup cg(ref bit [3:0]temp);
    coverpoint temp;
  endgroup
  initial
    begin
      cg c1,c2;
      c1=new(a);
      c2=new(b);
      repeat(20)
        begin
          a=$urandom();
          c1.sample();
          $display("a=%0d",a);
          #10;
        end
      
      repeat(20)
        begin
          b=$urandom();
          c2.sample();
          $display("b=%0d",b);
          #10;
        end
    end
  
endmodule

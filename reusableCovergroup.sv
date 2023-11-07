//reusable covergroup
//Example-1
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

//Example-2
module test;
  bit [3:0]a;
  bit [3:0]b;
  int max,min;
  covergroup cg(ref bit[3:0]temp,int max,int min);
    option.per_instance=1;
    coverpoint temp{
      bins used[]={[min:max]};
    }
  endgroup
  initial
    begin
      cg c,c1;
      max=10;min=5;
      c=new(a,max,min);
      repeat(20)
        begin
          a=$urandom();
          c.sample();
          #10;
        end
      max=10;min=1;
      c1=new(b,max,min);
      repeat(20)
        begin
          b=$urandom();
          c1.sample();
          #10;
        end
    end
      
endmodule


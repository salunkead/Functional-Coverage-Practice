//option.name use
module test;
  bit [3:0]a;
  bit [3:0]b;
  int max,min;
  string name;
  covergroup cg(ref bit[3:0]temp,int max,int min,string name);
    option.per_instance=1;
    option.name=name;
    coverpoint temp{
      bins used[]={[min:max]};
    }
  endgroup
  initial
    begin
      cg c,c1;
      max=10;min=5;
      name="coverpoint a";
      c=new(a,max,min,name);
      repeat(20)
        begin
          a=$urandom();
          c.sample();
          #10;
        end
      max=10;min=1;
      name="coverpoint b";
      c1=new(b,max,min,name);
      
      repeat(20)
        begin
          b=$urandom();
          c1.sample();
          #10;
        end
    end
      
endmodule

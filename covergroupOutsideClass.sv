//Declaring and defining covergroup outside the class

covergroup cg(ref bit[3:0]var1,int min,int max);
  option.per_instance=1;
  coverpoint var1{
    bins used[]={[min:max]};
  }
endgroup

class test;
  randc bit[3:0]num;
  cg c1;
  function new(int min,max);
    c1=new(num,min,max);
  endfunction
endclass

module top;
  test t;
  initial
    begin
      t=new(3,12);
      repeat(10)
        begin
          t.randomize;
          t.c1.sample();
          #1;
        end
    end
endmodule

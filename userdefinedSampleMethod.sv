////user defined sample method
module test;
  bit [3:0]num;
  covergroup cg with function sample(input bit [3:0]a);
    option.per_instance=1;
    option.goal=50;
    coverpoint a;
  endgroup
  
  initial
    begin
      cg c=new;
      repeat(30)
        begin
          num=$urandom;
          if(num%2==0)
            c.sample(num);
        end
    end
endmodule

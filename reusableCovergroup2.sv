//pass by value in a reuable covergroup
//the actual arguments of new method are copied into the formal arguments 
module test;
  reg [3:0]num;
  covergroup cg(int min,int max,string st)@(num);
    option.per_instance=1;
    option.name=st;
    coverpoint num{
      bins var1[]={[min:max]};
    }
  endgroup
  
  initial
    begin
      cg c1=new(0,3,"low_range");
      cg c2=new(4,7,"mid_range");
      cg c3=new(8,15,"high_range");
      
      repeat(30)
        begin
          num=$urandom_range(0,15);
          #1;
        end
    end
endmodule

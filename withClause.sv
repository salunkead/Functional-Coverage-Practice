//bins filtering using with clause
module test;
  bit [5:0]num;
  covergroup cg;
    option.per_instance=1;
    coverpoint num{
      bins cover1[]={[0:30]} with (item%6==0);///takes only specified range i.e 0 to 30 which is divisible by 6
      bins cover2[]=num with (item%6==0);///takes all the range 0 to 64 which is divisible by 6
    }
  endgroup
  
  initial
    begin
      cg c=new;
      repeat(30)
        begin
          num=$urandom;
          c.sample();
          #20;
        end
    end
endmodule

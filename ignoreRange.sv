//Ignore range of values
module test;
  reg[5:0]num;
  covergroup cg@(num);
    option.per_instance=1;
    option.name="ignore range";
    coverpoint num{
      ignore_bins ig[]={[0:10],[25:40],[60:63]};
    }
  endgroup
  
  initial
    begin
      cg c1=new;
      repeat(50)
        begin
          num=$urandom_range(0,63);
          #1;
        end
    end
endmodule

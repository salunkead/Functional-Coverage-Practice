//when a bin is included in valid bins as well as in illegal bin then that bin will be excluded from coverage calculation i.e it will be considered as illegal bin
// warning -> Bin(s) 'valid_bin[5]' are empty and will be excluded from the coverage report
module test;
  reg[2:0]a;
  
  covergroup cg@(a);
    option.per_instance=1;
    coverpoint a{
      bins valid_bin[]={[0:5]};
      illegal_bins invalid[]={[5:7]};
    }
  endgroup
  
  initial
    begin
      cg c1=new;
      repeat(20)
        begin
          a=$urandom_range(0,15);
          #1;
        end
    end
endmodule

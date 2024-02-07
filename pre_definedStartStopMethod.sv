//Pre-defined coverage Method -> start and stop 

module test;
  bit[3:0]num;
  bit wr;
  
  covergroup cg @(num or wr);
    option.per_instance=1;
    option.cross_num_print_missing=1;
    coverpoint num;
    coverpoint wr;
    cross num,wr{
      ignore_bins ig=binsof(wr) intersect {0};
    }
  endgroup
  
  initial
    begin
      cg c=new;
      repeat(50)
        begin
          num=$urandom;
          wr=$urandom;
          if(wr)
            c.start;
          else
            c.stop;
          #1;
        end
    end
endmodule

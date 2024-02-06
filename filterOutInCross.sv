//How to filter out some values from cross coverage using binsof and intersect operator
module test;
  bit [3:0]num;
  bit wr;
  covergroup cg@(num or wr);
    option.per_instance=1;
    option.cross_num_print_missing=1;
    cross num,wr  ///the auto bins will be created for num and wr
    {
      ignore_bins ig=binsof(num) intersect{[0:10]}; //ignore values from 0 to 10
      ignore_bins ig1=binsof(wr) intersect{0};  //ignore value 0 of wr,therefore the cross will be between 11-15 and 1
    }
  endgroup
  
  initial
    begin
      cg c=new;
      repeat(100)
        begin
          num=$urandom;
          wr=$urandom;
          #1;
        end
    end
endmodule

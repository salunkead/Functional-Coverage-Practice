//The option - cross_num_print_missing
/*
1.The option cross_num_print_missing gives detail about missing cross combination
*/
module test;
  bit [3:0]num;
  bit wr;
  covergroup cg@(num or wr);
    option.per_instance=1;
    option.cross_num_print_missing=1;
    num1:coverpoint num{
      bins valid[]={[0:10]};
    }
    wr_1:coverpoint wr{
      bins wr1={1};
    }
    cross num1,wr_1;
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

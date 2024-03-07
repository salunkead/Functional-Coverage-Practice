//The option - cross_num_print_missing
/*
1.The option cross_num_print_missing gives detail about missing cross combination
2.syntax:- option.cross_num_print_missing=number;
3.By default,simulator doesnot show missing cross bins by using this option we can get missing cross bins
*/

/////////////
module test;
  bit [3:0]num;
  bit wr;
  covergroup cg@(num or wr);
    option.per_instance=1;
    option.cross_num_print_missing=10;  //if there are 10 missing cross bins then it will show
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
      repeat(10)
        begin
          num=$urandom;
          wr=$urandom;
          #1;
        end
    end
endmodule

//wildcard Bins
/*
1.wildcard characters are x,z,? each of which evaluate to 0 and 1
*/
module test;
  reg[2:0]a;
  
  covergroup cg@(a);
    option.per_instance=1;
    coverpoint a{
      wildcard bins x[]={3'b00x}; //x covers 000,001
      wildcard bins z[]={3'b01z}; //z covers 010,011
      wildcard bins question_mark[]={3'b10?}; //it covers 100,101
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

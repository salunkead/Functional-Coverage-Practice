///$countbits() system task as a coverpoint

////////////////////////////
module test;
  reg[3:0]a;
  
  covergroup cg@(a);
    option.per_instance=1;
    
    coverpoint $countbits(a,1'bz){
      option.comment="System Task as coverpoint";
      bins two={2};
    }
    

  endgroup
  
  cg c1;
  initial
    begin
      c1=new;
      a=4'b1zz0;
      #5;
      a=4'b10z0;
      #5;
      a=4'b11zz;
      #5;
      a=4'b100x;
      #5;
      a=4'b0110;
    end
endmodule

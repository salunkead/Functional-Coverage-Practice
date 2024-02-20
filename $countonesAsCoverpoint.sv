//$countones() system task as a coverpoint

module test;
  bit[3:0]a;
  
  covergroup cg@(a);
    option.per_instance=1;
    
    coverpoint $countones(a){
      option.comment="System Task as coverpoint";
      bins ones={2};
    }
    

  endgroup
  
  cg c1;
  initial
    begin
      c1=new;
      a=4'b0000;
      #5;
      a=4'b1010;
      #5;
      a=4'b1100;
      #5;
      a=4'b1001;
      #5;
      a=4'b0110;
    end
endmodule

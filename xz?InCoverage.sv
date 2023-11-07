//how to handle x,z and ? in coverage
module test;
  reg [3:0]a;
  covergroup cg;
    coverpoint a{
      bins def[]={[0:15]};
      bins undef={4'b10?0,4'b?101};//single bin covers 1000,1010,0101,1101
      bins unk={4'b10xx,4'bxx10};//single bin covers 10xx and xx10
      bins imp={4'b10zz,4'bzz10};//single bin covers 10zz and zz10
    }
  endgroup
  initial
    begin
      cg c;
      c=new();
      a=4'b1010;
      c.sample();
      $display("a=%0b",a);
      a=4'b10?0;
      c.sample();
      $display("a=%0b",a);
      a=4'b0101;
      c.sample();
      $display("a=%0b",a);
      a=4'b?101;
      c.sample();
      $display("a=%0b",a);
      a=4'b10xx;
      c.sample();
      $display("a=%0b",a);
      a=4'bxx10;
      c.sample();
      $display("a=%0b",a);
      a=4'b10zz;
      c.sample();
      $display("a=%0b",a);
      a=4'bzz10;
      c.sample();
      $display("a=%0b",a);
    end
endmodule

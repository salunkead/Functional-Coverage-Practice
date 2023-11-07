module test;
  reg [3:0]a;
  covergroup cg;
    coverpoint a{
      bins a1[]={[0:7]};//bins 0 to 7 will be covered individually
      bins a2=default; //single bin, 8 to 15 will be covered in bin a2
    }
  endgroup
  initial
    begin
      cg c;
      c=new();
      repeat(30)
        begin
          a=$urandom();
          c.sample();
          #10;
        end
    end
endmodule

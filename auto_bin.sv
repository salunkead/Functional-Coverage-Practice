//auto_bin _max concept
module top;
  reg [7:0]a,b;
  covergroup cg;
    //option.auto_bin_max=256;// default auto bin max set by simulator is 64.if we declare it here it will be applicable to all coverpoint
    coverpoint a;
    coverpoint b{option.auto_bin_max=256;} //if we declare it like this it will be only considered for coverpoint b.
  endgroup
  initial
    begin
      cg c;
      c=new();
      repeat(50)
        begin
          a=$urandom();
          b=$urandom();
          c.sample();
        end
    end
endmodule

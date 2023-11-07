//wild card bins
module t;
  bit [3:0]a;
  covergroup cg;
    coverpoint a{
      wildcard bins low={4'b???0}; //? can be anything 0 or 1 but L.S.B bit must 0 
      wildcard bins high={4'b01??}; //3 and 2 bit must be 0 and 1 respectively but 1 and 0th bit can be anything 0 or 1
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
          $displayb(a);
          #10;
        end
        
    end
  initial
    begin
      $dumpfile("d.vcd");
      $dumpvars;
    end
endmodule

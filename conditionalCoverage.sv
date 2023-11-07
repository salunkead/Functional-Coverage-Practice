////cover value of a only when wr is high
module test;
  reg [3:0]a;
  reg wr;
  covergroup cg;
    valueA:coverpoint a iff(wr);
    coverpoint wr;
  endgroup
  initial
    begin
      cg c;
      c=new;
      repeat(20)
        begin
          a=$urandom;
          wr=$random;
          c.sample;
          #10;
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
endmodule

////alternate method using if with sample method
module test;
  reg [3:0]a;
  reg wr;
  covergroup cg;
    A1:coverpoint a;
  endgroup
  initial
    begin
      cg c;
      c=new;
      repeat(20)
        begin
          a=$urandom;
          wr=$random;
          if(wr)
            c.sample;
          #10;
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
endmodule

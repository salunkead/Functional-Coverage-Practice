//bins filtering 
//ways of bin filtering
/*
1. with clause
2. ignore_bin
3. illegal bin
4. wildcard_bin
*/
//1. with clause
module t;
  reg [4:0]a;
  covergroup cg;
    coverpoint a{
      bins used[]=a with (item%2==0);
                }
  endgroup
  initial
    begin
      cg c;
      c=new();
      repeat(50)
        begin
          a=$urandom();
          c.sample();
          #10;
        end
    end
  initial
    begin
      $dumpfile("d.vcd");
      $dumpvars;
    end
endmodule

//2.ignore bin
module t;
  reg [4:0]a;
  covergroup cg;
    coverpoint a{
      ignore_bins unused[]=a with (item%2==0);
                }
  endgroup
  initial
    begin
      cg c;
      c=new();
      repeat(50)
        begin
          a=$urandom();
          c.sample();
          #10;
        end
    end
  initial
    begin
      $dumpfile("d.vcd");
      $dumpvars;
    end
endmodule

//3 illegal bins:- throws error if specified value hits
module t;
  reg [4:0]a;
  covergroup cg;
    coverpoint a{
      illegal_bins unused[]=a with (item%2==0);
                }
  endgroup
  initial
    begin
      cg c;
      c=new();
      repeat(50)
        begin
          a=$urandom();
          c.sample();
          #10;
        end
    end
  initial
    begin
      $dumpfile("d.vcd");
      $dumpvars;
    end
endmodule 

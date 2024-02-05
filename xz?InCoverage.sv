//how to handle x,z in coverage
module test;
  reg [3:0]a;
  covergroup cg;
    coverpoint a{
      bins def[]={[0:15]};
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
      a=4'b1000;
      c.sample();
      $display("a=%0b",a);
      a=4'b0101;
      c.sample();
      $display("a=%0b",a);
      a=4'b1101;
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

//
//how to handle xxx(unknown) and zzz(high impedance)
module test;
  reg [2:0]state;
  bit clk;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    coverpoint state{
      bins default_st1={3'bxxx};
      bins default_st2[]=state with (item>4);
      bins valid_st[]=state with (item<4);
    }
  endgroup
  initial
    begin                                                                                                                                               
      cg c=new;
      repeat(30)
        begin
          @(posedge clk);
          state=$urandom;
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #300 $finish;
    end
endmodule

////////
module test;
  reg [2:0]state;
  bit clk;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    coverpoint state{
      bins unknown={3'bxxx};
      bins high_impedance={3'bzzz};
    }
  endgroup
  initial
    begin                                                                                                                                               
      cg c=new;
      @(posedge clk);
      state=3'bzzz;
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #20 $finish;
    end
endmodule

//////cross coverage
module test;
  bit [3:0]addr;
  bit wr;
  bit clk;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    WR1:coverpoint wr{
      bins wr1={1};
    }
    WR0:coverpoint wr{
      bins wr0={0};
    }
    ADDR:coverpoint addr;
    cross WR1,ADDR;  //when wr=1,all the values of addr are covered or not
    cross WR0,ADDR;  //when wr=0,all the values of addr are covered or not
  endgroup
  initial
    begin
      cg c=new;
      repeat(50)
        begin
          @(posedge clk);
          addr=$urandom;
          wr=$urandom;
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #500 $finish;
    end
endmodule

///cross coverage can be between coverpoint or variables or between coverpoint and variable
module test;
  enum {r,g,b}color;
  bit [1:0]offset;
  bit [3:0]addr;
  covergroup cg;
    option.per_instance=1;
    ofst:coverpoint offset;
    addr1:coverpoint addr{
      bins adr1={[0:7]};
      bins adr2={[8:15]};
    }
    clr_addr:cross color,addr; //states=3 implicit 16 total-3*16=48 cross coverage percentage=covered/total*100%
    addr_offset:cross addr,offset; //offset implict bins =4 and addr bins are 16--> total 4*16=64 covered/total*100%
  endgroup
  cg c;
  initial
    begin
      c=new;
      repeat(60)
        begin
          $cast(color,$urandom_range(0,2));
          offset=$urandom;
          addr=$urandom;
          c.sample;
          #20;
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
endmodule

//cross among multiple coverpoints.
module test;
  bit memRead,memWrite,cacheRead,cacheWrite;
  bit clk;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    Mwrite:coverpoint memWrite;
    Mread:coverpoint memRead;
    Cwrite:coverpoint cacheWrite;
    Cread:coverpoint cacheRead;
    MulipleCross:cross Mwrite,Mread,Cwrite,Cread;
  endgroup
  initial
    begin
      cg c=new;
      repeat(80)
        begin
          @(posedge clk);
          {memRead,memWrite,cacheRead,cacheWrite}=$urandom;
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #700 $finish;
    end
endmodule


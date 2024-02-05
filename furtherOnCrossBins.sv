///Behaviour of cross bin filtering 
///scene-1 variable cross
module test;
  bit [4:0]addr;
  bit clk,wr;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    cross addr,wr{
      ignore_bins c1=binsof(addr) intersect{[0:20]};
      ///consider the range from 21 to 31 for cross calculation
      ignore_bins c2=binsof(wr) intersect {0};
      //consider wr value of wr==1
    }
  endgroup
  
  initial
    begin
      cg c=new;
      repeat(250)
        begin
          @(negedge clk);
          addr=$urandom;
          wr=$urandom;
        end
      begin
        @(negedge clk);
        addr=30;
        wr=1;
      end
    end
  initial
    begin
      $dumpfile("cov.vcd");
      $dumpvars;
      #2020 $finish;
    end
endmodule

///scene-2 variable cross with ignore bin in cross
module test;
  bit [4:0]addr;
  bit clk,wr;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    cross addr,wr{
      ignore_bins c1=binsof(addr) intersect{[0:15]};
      ///ignore bins from 0 to 15 from coverage calculation
      ignore_bins c2=binsof(wr) intersect {1};
      //ignore bin wr==1 from coverage calvulation
    }
  endgroup
  
  initial
    begin
      cg c=new;
      repeat(250)
        begin
          @(negedge clk);
          addr=$urandom;
          wr=$urandom;
        end
      begin
        @(negedge clk);
        addr=30;
        wr=1;
      end
    end
  initial
    begin
      $dumpfile("cov.vcd");
      $dumpvars;
      #2020 $finish;
    end
endmodule

////
module test;
  bit [4:0]addr;
  bit clk,wr;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    coverpoint addr{
      bins a1[]={[5:10]};
      bins a2[]={[20:$]};
    }
    coverpoint wr{
      bins wr1={1};
      bins wr0={0};
    }
     ///we are taking cross of two coverpoints addr and wr
     ///in addr coverpoint,we have taken two bins a1 and a2 and cross will be considered for taking into the consideration of these two bins
    cross addr,wr{
      ignore_bins c1=binsof(addr)intersect{[5:10]};
      ///addr range from 20 to 31 is considered
      ignore_bins c2=binsof(wr)intersect{0};
      ///wr 1 is considered for coverage calculation
    }
  endgroup
  
  initial
    begin
      cg c=new;
      repeat(250)
        begin
          @(negedge clk);
          addr=$urandom;
          wr=$urandom;
        end
      begin
        @(negedge clk);
        addr=30;
        wr=1;
      end
    end
  initial
    begin
      $dumpfile("cov.vcd");
      $dumpvars;
      #2020 $finish;
    end
endmodule

/////scene-2 logical and of bins of coverpoint
module test;
  bit [4:0]addr;
  bit clk,wr;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    coverpoint addr{
      bins a1[]={[5:10]};
      bins a2[]={[20:$]};
    }
    coverpoint wr{
      bins wr1={1};
      bins wr0={0};
    }
    cross addr,wr{
      ignore_bins c1=binsof(addr.a1)&&binsof(wr.wr1);
     //in cross,there will be cross of 5 to 10 with 0
     //and cross of a2 bin [20:$] with 1 as well as 0
    }
  endgroup
  
  initial
    begin
      cg c=new;
      repeat(250)
        begin
          @(negedge clk);
          addr=$urandom;
          wr=$urandom;
        end
      begin
        @(negedge clk);
        addr=30;
        wr=1;
      end
    end
  initial
    begin
      $dumpfile("cov.vcd");
      $dumpvars;
      #2020 $finish;
    end
endmodule

///logical not in cross 
module test;
  bit [4:0]addr;
  bit clk,wr;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    coverpoint addr{
      bins a1[]={[5:10]};
      bins a2[]={[20:$]};
    }
    coverpoint wr{
      bins wr1={1};
      bins wr0={0};
    }
    cross addr,wr{
      bins c1=!binsof(addr.a1)&&binsof(wr.wr1);
//not of addr.a1 and wr.wr1,means addr1.a1 can cross with wr1 and wr2
///a2 cross with wr0
//c1=<a2,wr1>
    }
  endgroup
  
  initial
    begin
      cg c=new;
      repeat(250)
        begin
          @(negedge clk);
          addr=$urandom;
          wr=$urandom;
        end
      begin
        @(negedge clk);
        addr=30;
        wr=1;
      end
    end
  initial
    begin
      $dumpfile("cov.vcd");
      $dumpvars;
      #2020 $finish;
    end
endmodule

////all options
bit [7:0] var1, var2;
covergroup c_group @(posedge clk);
  cp1: coverpoint var1 {
                         bins x1 = { [0:99] };
                         bins x2 = { [100:199] };
                         bins x3 = { [200:255] };
                       }

  cp2: coverpoint var2 {
                         bins y1 = { [0:74] };
                         bins y2 = { [75:149] };
                         bins y3 = { [150:255] };
                       }

  cp1_X_cp2: cross cp1, cp2 {
                         bins xy1 = binsof(cp1.x1);
                         bins xy2 = binsof(cp2.y2);
                         bins xy3 = binsof(cp1.x1) && binsof(cp2.y2);
                         bins xy4 = binsof(cp1.x1) || binsof(cp2.y2);
                       }
endgroup

/*The cross bin xy1: It results in 3 cross products listed as

<x1, y1>, <x1, y2>, <x1, y3>

The cross bin xy2: It results in 3 cross products listed as

<x1, y2>, <x2, y2>, <x3, y2>

The cross bin xy3: It results in 1 cross-product listed as

<x1, y2>

The cross bin xy4: It results in 5 cross products listed as
Ezoic

<x1, y1>, <x1, y2>, <x1, y3>, <x2, y2>, <x3, y2>
*/


///intersect construct in cross
//syntax:---> binsof(coverpoint) intersect {range of values};
module test;
  bit [4:0]addr;
  bit clk,wr;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    coverpoint addr{
      bins a1[]={[5:10]};
      bins a2[]={[20:$]};
    }
    coverpoint wr{
      bins wr1={1};
      bins wr0={0};
    }
    cross addr,wr{
      bins c1=binsof(addr.a1) intersect {9,10};
      ///only consider 9 and 10
      bins c1=!binsof(addr.a1) intersect {9,10};
      //consider values except 9,10
    }
  endgroup
  
  initial
    begin
      cg c=new;
      repeat(250)
        begin
          @(negedge clk);
          addr=$urandom;
          wr=$urandom;
        end
      begin
        @(negedge clk);
        addr=30;
        wr=1;
      end
    end
  initial
    begin
      $dumpfile("cov.vcd");
      $dumpvars;
      #2020 $finish;
    end
endmodule

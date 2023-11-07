/*
there are three methods of sampling values in covergroup
1.covergroup name@(posedge clk);
2.covergroup name;
  endgroup
  while sampling values 
  @(posedge clk);
  obj.sample();
3.implementing user defined sampling method  
*/
//method-1
module test;
  reg [3:0]a;
  reg clk=0;
  reg en=0;
  always #5 clk=~clk;
  always #10 en=!en;
  covergroup cg @(posedge en);
    option.per_instance=1;
    option.goal=60;
    option.name="coverpoint a";
    coverpoint a{
      
      bins used[]={[5:10]};
      bins unused=default;
    }
  endgroup
  initial
    begin
      cg c;
      c=new();
      repeat(20)
        begin
          @(posedge en);
          a=$urandom();
        end
    end
  initial
    begin
      $dumpfile("d.vcd");
      $dumpvars;
      #210 $finish();
    end
          
      
endmodule


//method-2
module test;
  reg [3:0]a;
  reg clk=0;
  reg en=0;
  always #5 clk=~clk;
  always #10 en=!en;
  covergroup cg;
    option.per_instance=1;
    option.goal=60;
    option.name="coverpoint a";
    coverpoint a{
      
      bins used[]={[5:10]};
      bins unused=default;
    }
  endgroup
  initial
    begin
      cg c;
      c=new();
      repeat(20)
        begin
          @(posedge en);
          a=$urandom();
          c.sample();
        end
    end
  initial
    begin
      $dumpfile("d.vcd");
      $dumpvars;
      #210 $finish();
    end
endmodule

//method -3
module test;
  reg [3:0]a,b;
  string n;
  covergroup cg with function sample(input reg [3:0]temp);
    coverpoint temp{
      bins used[]={[5:12]};
    }
  endgroup
  initial
    begin
      cg c1,c2;
      c1=new();
      repeat(10)
        begin
          a=$urandom();
          c1.sample(a);
          #10;
        end
      c2=new();
      repeat(10)
        begin
          b=$urandom();
          c2.sample(b);
          #10;
        end
          
    end
endmodule

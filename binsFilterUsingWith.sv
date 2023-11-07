//cross using with- bins filtering 

module test;
  bit [4:0]a;
  bit clk;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    coverpoint a{
      bins two[]=a with (item%2==0);
      bins three[]=a with (item%3==0);
    }
  endgroup
  
  initial
    begin
      cg c=new;
      repeat(50)
        begin
          a=$urandom;
          @(posedge clk);
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #500 $finish;
    end
endmodule


////
module test;
  bit [4:0]a,b;
  bit clk;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
   c_a:coverpoint a{
     bins two[]=c_a with (item%2==0);
     bins three[]=c_a with (item%3==0);
    }
    cross c_a,b{
      bins ab=binsof(c_a.two) with (a>7)&&binsof(c_a.three) with (a<10);
    }
  endgroup
  
  initial
    begin
      cg c=new;
      repeat(50)
        begin
          {a,b}=$urandom;
          @(posedge clk);
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #500 $finish;
    end

///covergroup-passing arguments
//passing arguments to the covergroup
module test;
  bit [7:0]addr1,addr2;
  bit clk;
  always #5 clk=~clk;
  covergroup cg(int max,min,string st,ref bit[7:0]addr)@(posedge clk);
    option.per_instance=1;
    option.name=st;
    address:coverpoint addr{
      bins addr1[]={[max:min]};
    }
  endgroup
  
  cg c,c1;
  initial
    begin
      c=new(20,10,"addr1",addr1);
      repeat(20)
        begin
          @(posedge clk);
          addr1=$urandom_range(20,10);
        end
      c1=new(50,30,"addr2",addr2);
      repeat(20)
        begin
          @(posedge clk);
          addr2=$urandom_range(50,30);
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #500 $finish;
    end
endmodule

//Design Module
module FIFO(input clk, rst, wr, rd, 
                input [7:0] din,output reg [7:0] dout,
                output reg empty, full);
      
      reg [3:0] wptr = 0,rptr = 0,cnt = 0;
      reg [7:0] mem [15:0];
      
      always@(posedge clk)
        begin
          if(rst== 1'b1)
             begin
               cnt <= 0;
               wptr <= 0;
               rptr <= 0;
             end
          else if(wr && !full)
              begin
                if(cnt < 15) begin
                mem[wptr] <= din;
                wptr <= wptr + 1;
                cnt <= cnt + 1;
                end
              end
          else if (rd && !empty)
            begin
              if(cnt > 0) begin
              dout <= mem[rptr];
              rptr <= rptr + 1;
              cnt <= cnt - 1;
              end
            end 
          
          if(wptr == 15)
             wptr <= 0;
          if(rptr == 15)
             rptr <= 0;
        end
      
      assign empty = (cnt == 0) ? 1'b1 : 1'b0;
      assign full = (cnt == 15) ? 1'b1 : 1'b0;
endmodule

//Testbench Module with coverage 
module tb;
  reg clk,rst,rd,wr;
  reg [7:0]din;
  wire [7:0]dout;
  wire empty,full;
  FIFO dut(clk,rst,wr,rd,din,dout,empty,full);
  initial clk=0;
  always #5 clk=~clk;
  task reset;
    rst=1;
    rd=0;
    wr=0;
    din=0;
    repeat(3)@(negedge clk);
    rst=0;
  endtask
//write then read
  task test1;
    repeat(15)
      begin
        wr=1;
        din=$urandom();
        @(negedge clk);
      end
    repeat(15)
      begin
        wr=0;
        rd=1;
        @(negedge clk);
      end
  endtask
//write and read consecutively
  task write;
    wr=1;
    rd=0;
    din=$urandom();
    @(negedge clk);
  endtask
  task read;
    wr=0;
    rd=1;
    @(negedge clk);
  endtask
  
//rst signal is asserted during the write operation
  task test2;
    wr=1;
    rd=0;
    repeat(8)
      begin
        din=$urandom();
        @(negedge clk);
      end
    rst=1;
    repeat(2)@(negedge clk);
    repeat(15)
      begin
        rst=0;
        din=$urandom();
        @(negedge clk);
      end
  endtask
//reset is asserted during read operation
  task test3;
    repeat(5)
      begin
        wr=0;
        rd=1;
        @(negedge clk);
      end
    rst=1;
    repeat(2)@(negedge clk);
    rst=0;
  endtask
//writing data into fifo after fifo is out of its depth
// and making sure that full is asserted after full depth of fifo
  task test4;
    repeat(20)
      begin
        wr=1;
        rd=0;
        din=$urandom;
        @(negedge clk);
      end
  endtask
  covergroup cg@(posedge clk);
    option.name="all write locations";
    option.per_instance=1;
    wr1:coverpoint wr{
      bins one={1};
    }
    ptr:coverpoint dut.wptr;
    cross wr1,ptr;
  endgroup
  covergroup cg1@(posedge clk);
    option.name="all read locations";
    option.per_instance=1;
    rd:coverpoint rd{
      bins one={1};
    }
    rdptr:coverpoint dut.rptr;
    cross rd,rdptr;
  endgroup

   cg c;
  cg1 c1;
  initial
    begin
      c=new();
      c1=new();
      reset();
      test1();
      repeat(15)
        begin
          write();
          read();
        end
      test2;
      test3;
      test4;
    end
  initial
    begin
      
      $dumpfile("fifo.vcd");
      $dumpvars(1,tb.dut);
      #1500 $finish();
    end  
endmodule

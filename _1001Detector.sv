//Design Module
module _1001detector(
input clk,rst,
input in,
output out);
  typedef enum bit [1:0]{s0,s1,s2,s3}state_type;
  state_type prst,nxt;
  always @(posedge clk)
    begin
      if(rst)
        begin
          prst<=s0;
        end
      else
        prst<=nxt;
    end
  always@(*)
    begin
      case(prst)
        s0:
          begin
            if(in)
              nxt=s1;
            else
              nxt=s0;
          end
        s1:
          begin
            if(!in)
              nxt=s2;
            else
              nxt=s1;
          end
        s2:
          begin
            if(!in)
              nxt=s3;
            else
              nxt=s1;
          end
        s3:
          begin
            if(in)
              begin
                nxt=s0;
              end
            else
              begin
                nxt=s0;
              end
          end
        default: nxt=s0;
      endcase
    end
assign out=(prst==s3 && in==1)?1'b1:1'b0;
endmodule

//Testbench with Coverage
module tb;
  bit clk,rst,in;
  logic out;
bit [3:0] temp;
  _1001detector dut(clk,rst,in,out);
  initial repeat(50) #5 clk=!clk;
  task reset;
    rst=1;
    in=0;
    repeat(2)@(posedge clk);
    rst=0;
  endtask
  task inputs;
   temp=4'b1001;
   for(int i=0;i<4;i++)
     begin
       in=temp[i];
       @(negedge clk);
     end
    repeat(20)
      begin
        in=$urandom;
        @(negedge clk);
      end
  endtask
  covergroup cg@(posedge clk);
    in1:coverpoint dut.prst{
      bins s0tos0=(dut.s0=>dut.s0);
      bins s0tos1=(dut.s0=>dut.s1);
      bins s1tos1=(dut.s1=>dut.s1);
      bins s1tos2=(dut.s1=>dut.s2);
      bins s2tos1=(dut.s2=>dut.s1);
      bins s2tos3=(dut.s2=>dut.s3);
      bins s3tos0=(dut.s3=>dut.s0);
    }
  endgroup
  cg c;
  initial
    begin
      c=new();
      reset;
      inputs;
    end
  initial
    begin
      $dumpfile("fsm.vcd");
      $dumpvars(1,tb.dut);
    end
endmodule

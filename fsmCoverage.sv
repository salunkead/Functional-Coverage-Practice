//fsm coverage 
// Design Module
module fsm(
  input clk,rst,in,
  output reg out);
  typedef enum bit[1:0]{a,b,c}state_type;
  state_type state,nxt_state;
  always@(posedge clk)
    begin
      if(rst)
        state<=a;
      else
        state<=nxt_state;
    end
  always@(*)
    begin
      case(state)
        a:
          begin
            out=0;
            if(!in)
              nxt_state=a;
            else
              nxt_state=b;
          end
        b:
          begin
            if(in)
              begin
                nxt_state=b;
                out=0;
              end
            else
              begin
                nxt_state=c;
                out=0;
              end
          end
        c:
          begin
            if(in)
              begin
                nxt_state=b;
                out=1;
              end
            else
              begin
                nxt_state=a;
                out=0;
              end
          end
        default:nxt_state=a;
      endcase
    end
endmodule


// Testbench Module with coverage
module test;
  reg clk,rst,in;
  wire out;
  fsm dut(clk,rst,in,out);
  initial clk=0;
  always #5 clk=~clk;
  task reset();
    in=0;
    rst=1;
    repeat(3) @(posedge clk);
    rst=0;
  endtask
  task write();
    @(posedge clk);
    in=$random();
  endtask
  covergroup cg @(posedge clk);
    option.per_instance=1;
    coverpoint in iff(!rst){
      bins in_l={0};
    }
    coverpoint dut.state{
      bins a_a=(dut.a=>dut.a);
      bins b_c=(dut.b=>dut.c);
      bins c_a=(dut.c=>dut.a);
    }
    zero_to_state:cross in,dut.state;
  endgroup
  covergroup cg1 @(posedge clk);
    option.per_instance=1;
    coverpoint in iff(!rst){
      bins in_h={1};
    }
    coverpoint dut.state{
      bins a_b=(dut.a=>dut.b);
      bins b_b=(dut.b=>dut.b);
      bins c_b=(dut.c=>dut.b);
    }
    one_to_state:cross in,dut.state;
  endgroup
  cg c1;
  cg1 c2;
  initial
    begin
      c1=new();
      c2=new();
      reset();
      repeat(40) write();
    end
  initial
    begin
      $dumpfile("f.vcd");
      $dumpvars(1,test.dut);
      #400 $finish;
    end
endmodule

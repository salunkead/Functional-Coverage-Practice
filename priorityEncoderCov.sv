//8:3 priority encoder
//Design Module
module priorityEn(
  input en,
  input [7:0]in,
  output reg [2:0]out);
  always@(*)
    begin
      if(en)
        out=0;
      else if(!en)
        begin
          casex(in)
            8'b1???????:out=3'b111;
            8'b01??????:out=3'b110;
            8'b001?????:out=3'b101;
            8'b0001????:out=3'b100;
            8'b00001???:out=3'b011;
            8'b000001??:out=3'b010;
            8'b0000001?:out=3'b001;
            8'b00000001:out=3'b000;
            default:out=3'b000;
          endcase
        end
    end
endmodule

//Testbench Module with coverage
module tb;
  reg en;
  reg [7:0]in;
  wire [2:0]out;
  priorityEn dut(en,in,out);
  task reset;
    en=1;
    in=0;
    p.sample();
    #20;
    en=0;
  endtask
  task inputs;
    repeat(50)
      begin
        in=$urandom();
        p.sample();
        $display("in=%b",in);
        #20;
      end
  endtask
  covergroup pri();
    coverpoint in iff(!en){
      wildcard bins in0={8'b00000001};
      wildcard bins in1={8'b0000001?};
      wildcard bins in2={8'b000001??};
      wildcard bins in3={8'b00001???};
      wildcard bins in4={8'b0001????};
      wildcard bins in5={8'b001?????};
      wildcard bins in6={8'b01??????};
      wildcard bins in7={8'b1???????};
    }
  endgroup
  pri p;
  initial
    begin
      p=new();
      reset();
      inputs();
    end
  initial
    begin
      $dumpfile("encode.vcd");
      $dumpvars(1,tb.dut);
    end
endmodule

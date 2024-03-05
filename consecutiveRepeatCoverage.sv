///consecutive repeatition and transition coverage
module test;
  bit clk;
  bit [3:0]addr;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    option.comment="bins for transition coverage";
    coverpoint addr{
      bins addrb1=(1=>2=>3);
      bins addrb2[]=(1,2=>3,4);///4 possible combintions are 1->3,1->4,2->3,2->4
      bins addrb3=(1[*2]=>2[*2]); //one for two consecutive clock cycles then in next clock cycle 2 for two consecutive clock cyles
    }
  endgroup
  initial
    begin
      cg c=new;
      repeat(50)
        begin
          addr=$urandom_range(0,5);
          @(posedge clk);
        end
      begin
        @(negedge clk);
        addr=1;
        @(negedge clk);
        addr=2;
        @(negedge clk);
        addr=3;
      end
      begin
        repeat(2)@(negedge clk);
        addr=1;
        repeat(2)@(negedge clk);
        addr=2;
      end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #600 $finish;
    end
endmodule


///////
module test;
  bit clk;
  bit [3:0]state;
  always #5 clk=~clk;
  covergroup cg@(posedge clk);
    option.per_instance=1;
    option.comment="bins for transition coverage";
    coverpoint state{
      //bins trans1[]=(1,2=>3,4);
      bins trans2=(1=>3,1=>4,2=>3,2=>4); //this is not same as above
                                         //1->(3 or 1)->(4 or 2)->(3 or 2)->4
    }
  endgroup
  initial
    begin
      cg c=new;
        begin:transition1
          @(negedge clk);
          state=1;
          @(negedge clk);
          state=3;
          @(negedge clk);
          state=4;
          @(negedge clk);
          state=3;
          @(negedge clk);
          state=4;
        end
       begin:transition2
          @(negedge clk);
          state=1;
          @(negedge clk);
          state=1;
          @(negedge clk);
          state=2;
          @(negedge clk);
          state=3;
          @(negedge clk);
          state=4;
        end
       begin:transition3
          @(negedge clk);
          state=1;
          @(negedge clk);
          state=3;
          @(negedge clk);
          state=2;
          @(negedge clk);
          state=3;
          @(negedge clk);
          state=4;
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #600 $finish;
    end
endmodule

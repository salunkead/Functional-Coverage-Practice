//various coverage options 
module test;
  bit [3:0]num,num1;
  
  covergroup cg@(num or num1);
    
    option.per_instance=1;  //tracks the coverage info. for each instance of cg in addition to the overall coverage info.
    option.name="auto_bin_max";
    option.comment="Demonstration of options";
    option.cross_num_print_missing=1;
    type_option.goal=80;
    type_option.strobe=1;  //all samples in this covergroup happens at the end of time slot (same as $strobe system task)
    
    coverpoint num{
      option.weight=3;
      option.at_least=2;
    }
    coverpoint num1{
      option.auto_bin_max=10; //creates maximum 10 auto bins for coverpoint num1
      option.weight=2;      //specifies the weight of this coverpoint for calculation of overall coverage
      option.at_least=3; //any bin is considered cover only when it is hit atlest 3 times
    }
    
    cross num,num1{
      ignore_bins ig1=binsof(num) intersect {[11:$]};
      ignore_bins ig2=binsof(num1) intersect {[11:$]};
    }
  
  endgroup
  
  initial
    begin
      cg c1=new;
      repeat(30)
        begin
          num=$urandom_range(0,15);
          num1=$urandom_range(0,15);
          #1;
        end
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
endmodule

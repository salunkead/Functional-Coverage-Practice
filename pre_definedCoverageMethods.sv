//Pre-defined coverage methods

module test;
  bit[3:0]num;
  bit[2:0]num1;
  covergroup cg(int a,int b);
    option.per_instance=1;
    coverpoint num{
      bins num_bins[]={[0:a]};
    }
    coverpoint num1{
      bins num1_bins[]={[0:b]};
    }
  endgroup
  
  initial
    begin
      cg c1=new(10,8);
      cg c2=new(12,5);
      
      repeat(30)
        begin
          num=$urandom;
          num1=$urandom;
          c1.sample;
          c2.sample;
          #1;
        end
      
      c1.set_inst_name("instance c1");
      $display("overall coverage for the instance c1 is : %0.4f",c1.get_inst_coverage);
      $display("total coverage of coverpoint num for instance c1 is : %0.4f",c1.num.get_inst_coverage());
      $display("total coverage of coverpoint num1 for instance c1 is : %0.4f",c1.num1.get_inst_coverage());
      $display("-------------------------------------------------------------------");
      c2.set_inst_name("instance c2");
      $display("overall coverage for the instance c2 is : %0.4f",c2.get_inst_coverage);
      $display("total coverage of coverpoint num for instance c2 is : %0.4f",c2.num.get_inst_coverage());
      $display("total coverage of coverpoint num1 for instance c2 is : %0.4f",c2.num1.get_inst_coverage());
      $display("-------------------------------------------------------------------");
      $display("overall coverage for all the instances is : %0.4f",cg::get_coverage);
      $display("overall coverage for the coverpoint num is : %0.4f",cg::num::get_coverage);
      $display("overall coverage for the coverpoint num1 is : %0.4f",cg::num1::get_coverage);
    end
  
endmodule

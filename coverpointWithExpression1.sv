///coverpoint with an integral expression
/*
1.coverpoint can use expression that results in an integral value.the expression is evaluated and the result is used for coverage analysis

*/


////////////////////////
module test;
  bit[3:0]a,b;
  
  covergroup cg@(a,b);
    option.per_instance=1;
    
    coverpoint a+b{
      option.comment="Addition";
      bins sum_8={8};
    }
    coverpoint a*b{
      option.comment="Multiplication";
      bins mul_16={12};
    }
    coverpoint a/b{
      option.comment="Division";
      bins division_4={4};
    }
    coverpoint a-b{
      option.comment="Substraction";
      bins sub_10={10};
    }

  endgroup
  
  cg c1;
  initial
    begin
      c1=new;
      a=4;
      b=4;
      #5;
      a=6;
      b=2;
      #5;
      a=12;
      b=3;
      #5;
      a=12;
      b=2;
    end
endmodule

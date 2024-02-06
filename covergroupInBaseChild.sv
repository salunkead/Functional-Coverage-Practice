//Declaring covergroup in base and child class
class variables;
  randc bit[3:0]num;
  function void post_randomize;
    $display("num=%0d",num);
  endfunction
endclass
class base;
  variables var1;
  covergroup cg;
    option.per_instance=1;
    coverpoint var1.num{
      bins used[]={[0:10]};
    }
  endgroup
  
  function new();
    var1=new;
    cg=new;
  endfunction
endclass

class child extends base;
  covergroup cg;
    option.per_instance=1;
    coverpoint var1.num{
      bins used[]={[11:$]};
    }
  endgroup
  function new();
    super.new;
    cg=new;
  endfunction
endclass

module top;
  base b1;
  child c1;
  initial
    begin
      c1=new;
      b1=new;
      repeat(16)
        begin
          c1.var1.randomize;
          b1.var1.randomize;
          c1.cg.sample();  //the sample method is used to trigger the sampling of the coverage points mannually,the sample method takes no arguments and returns void 
          b1.cg.sample();
          #1;
        end
    end
endmodule

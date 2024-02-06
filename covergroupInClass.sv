//Declaring covergroup in class
class test;
  randc bit[3:0]num;
  function void post_randomize;
    $display("num: %0d",num);
  endfunction
endclass

class test1;
  test t;
  covergroup cg;
    option.per_instance=1;
    coverpoint t.num{
      bins valid[]={[0:10]};
    }
  endgroup
  
  function new();
    t=new();
    cg=new;
  endfunction
  
  task random_values;
    repeat(16)
      begin
        t.randomize;
        cg.sample;
        #1;
      end
  endtask
endclass

module top;
  test1 t1;
  initial
    begin
      t1=new;
      t1.random_values;
    end
endmodule

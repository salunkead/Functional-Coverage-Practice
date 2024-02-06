//Passing arguments to an embedded covergroup
class test;
  randc bit[3:0]num;
  function void post_randomize;
    $display("num: %0d",num);
  endfunction
endclass

class test1;
  test t;
  covergroup cg(int min,max);
    option.per_instance=1;
    coverpoint t.num{
      bins valid[]={[min:max]};
    }
  endgroup
  
  function new(int min,int max);
    t=new();
    cg=new(min,max);
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
      t1=new(0,12);
      t1.random_values;
    end
endmodule

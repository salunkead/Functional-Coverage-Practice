//bins and coverpoint using an expression
module test;
  bit [4:0]serial_word;
  covergroup cg;
    option.per_instance=1;
    coverpoint $countones(serial_word){
      bins set_bits_count[]={[0:$bits(serial_word)]};
    }
  endgroup
  
  initial
    begin
      cg c=new;
      repeat(30)
        begin
          serial_word=$urandom;
          $display("serial_word=%b",serial_word);
          c.sample();
          #20;
        end
    end
endmodule

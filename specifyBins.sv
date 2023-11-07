//different ways of specifying bins
module test;
  reg [3:0]a;
  covergroup cg;
    option.per_instance=1;
    coverpoint a{
      bins used[]={[5:$]}; // 5 to last individual bins
      bins used1={[5:$]};  //single bin for 5 to 15 if any one hits coverage for that bin will be 100%
      bins used2={0};      //look for only zero value 
      bins used3[]={0,8,9,10} // 4 bins of 0,8,9,10
      bins used4[]={[2:4]} //3 bins 2,3,4
      bins used[2]={[0:3]}; //4/2=2 2 bins created 1st bin will cover 0,1 and second bin will cover 2,3
}
  endgroup
  initial
    begin
      cg c;
      c=new();
      repeat(10)
        begin
          a=$urandom();
          c.sample();
          $info("a=%0d",a);
          #10;
        end
    end
  initial
    begin
      $dumpfile("dump.vcd"); $dumpvars;
    end
          
endmodule

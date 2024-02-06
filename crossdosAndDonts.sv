//Do's and Don't in cross coverage
module test;
  bit[3:0]a,b;
  
  covergroup cg@(a or b);
    A:coverpoint a{
      bins used[]={[0:10]};
      bins unused[]=default;
    }
    
    B:coverpoint b{
      bins use1[]={3,10,[11:13]};
    }
    
    cross1:cross A,B{
      bins cb1=binsof(A); //correct use
      bins cb2=binsof(A.used); //correct use
      bins cb3=binsof(A.unused); //incorrect use because unused is default bin
      bins cb4[]=binsof(B) //incorrect use -> as cb4 is declared as vector,cannot use vector inside cross
      bins cb5=default; //incorrect use -> we cannot use default in cross
    }
  endgroup
  
  initial 
    begin
      cg c1=new;
      repeat(10)
        begin
          {a,b}=$urandom;
          #1;
        end
    end
  
endmodule

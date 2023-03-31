with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure fileio is

   infp : file_type;
   outfp : file_type;
   i, sum : integer;

begin

   sum := 0;
   open(infp,in_file,"rainfall.dat");
   open(outfp,out_file,"output.dat");

   set_output(outfp);

   loop
      exit when end_of_file(infp);

      get(infp,i);
      sum := sum + i;
      put(sum); new_line;
   end loop;

   

   close(infp);
   close(outfp);

end fileio;
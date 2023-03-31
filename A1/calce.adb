-- Name: Carson Mifsud
-- Student Number: 1089936
-- Email: cmifsud@uoguelph.ca
-- Assignment Number: 4
-- Date: April 8, 2022

-- Description: This program takes a user-entered number of 
-- digits to be calculated for e, and saves the value of e calculated
-- in an ASCII file which is entered by the user.

with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with ada.Numerics.Elementary_Functions; use ada.Numerics.Elementary_Functions;

-- The main program calls the procedures ecalculation and keepe.
-- This program also prompts the user for the number of significant 
-- digits and the name of the file in which to store the value of
-- e calculated.
procedure calce is

   type e_array is array (0..2001) of integer;

   sig_dig : integer := 0;
   file_name, user_input : unbounded_string;
   d : e_array;

-- This subprogram saves the value of e calculated in an ASCII file.
-- It takes as input the calculated value of e, and the filename 
-- specified by the user.
   procedure keepe(d : in e_array; file_name : in unbounded_string; sig_dig : in integer) is

      i : integer := 0;
      outfp : file_type;
      infp : file_type;

      -- Variable used for checking if the output file already exists
      is_found : boolean := true;

   begin

      -- Error check if file exists using an exception to ensure program does not crash due to a name_error
      begin
         open(infp, in_file, to_string(file_name));
         close(infp);
      exception
         when name_error => is_found := false;
      end;

      -- If no file was found create a new file and write the data to the file
      if is_found = false then
         create(outfp, out_file, to_string(file_name));

         -- Set the output to write to the file
         set_output(outfp);

         -- Write data to the file
         put(d(0), Width => 0);
         put('.');
         i := 1;
         while i < sig_dig loop
            put(d(i), Width => 0);
            i := i + 1;
         end loop;

         -- Close file
         close(outfp);

         -- Set output back to standard output
         set_output(standard_output);
         put_line("");
         put_line("File write successful!");
         put_line("");

      -- If the file is found, open it and overwrite it
      else
         open(outfp, out_file, to_string(file_name));

         -- Set the output to write to the file
         set_output(outfp);

         -- Write data to the file
         put(d(0), Width => 0);
         put('.');
         i := 1;
         while i < sig_dig loop
            put(d(i), Width => 0);
            i := i + 1;
         end loop;

         -- Close file
         close(outfp);

         -- Set output back to standard output
         set_output(standard_output);
         put_line("");
         put_line("File write successful!");
         put_line("");

      end if;

   end keepe;

-- This procedure for calculating the transcendental
-- number e to n correct decimal places uses only integer 
-- arithmetic, except for estimating the required series 
-- length. The digits of the result are placed in the array 
-- d, the array element d[0] containing entier(e), and the
-- subsequent elements the following digits. These digits
-- are individually calculated
   procedure ecalculation(n : in integer; d : out e_array) is

      m, i, j, carry, temp : integer := 0;
      test : float := 0.0;
      coef : e_array;

   begin

      m := 4;
      test := (Float(n) + 10.0) * 2.30258509;

      -- Calculate number of required indices
      while (Float(m) * (log(Float(m)) - 1.0) + 0.5 * log(6.2831852 * Float(m)) < test) loop
         m := m + 1;
      end loop;

      -- Initialize required indices in coef
      j := 2;
      while j /= m loop
         coef(j) := 1;
         j := j + 1;
      end loop;

      -- Calculate digits of e
      d(0) := 2;
      i := 1;
      while i /= n+1 loop
         carry := 0;
         j := m-1;
         while j /= 1 loop
            temp := (coef(j) * 10) + carry;
            carry := temp / j;
            coef(j) := temp - (carry * j);
            j := j - 1;
         end loop;
         d(i) := carry;
         i := i + 1;
      end loop;

   end ecalculation;

begin

   put_line("");
   put("Calculating e to many digits in ADA!");
   put_line("");

   -- Prompt user for number of significant digits
   put_line("");
   put("Please enter the number of significant digits to calculate: ");
   get_line(user_input);

   -- Convert string to int
   sig_dig := Integer'Value(to_string(user_input));

   -- Check to make sure user input is greater than 2 if not continuously prompt user for valid input
   while (sig_dig < 2) loop
      put_line("");
      put("Input Error: The number of significant digits must be greater than 2");
      put_line("");
      put("Please enter the number of significant digits to calculate: ");
      get_line(user_input);

      -- Convert string to int
      sig_dig := Integer'Value(to_string(user_input));
   end loop;

   -- Prompt user for name of the output file
   put_line("");
   put("Please enter the name of the file in which to store the value of e calculated: ");
   get_line(file_name);

   ecalculation (sig_dig, d);
   keepe (d, file_name, sig_dig);

end calce;
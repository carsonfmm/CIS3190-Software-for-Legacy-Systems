-- Name: Carson Mifsud
-- Student Number: 1089936
-- Email: cmifsud@uoguelph.ca
-- Assignment Number: 2
-- Date: March 4, 2022

-- Description: This program contains the procedures for the imagepgm package, which deals with 
-- the input and output of images stored using the "P2" file format

with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;

-- This package deals with the input and output of images stored using the "P2" file format
package body imagepgm is

   -- This procedure takes an input file and returns a record representing the image
   procedure readPGM(read_pgm_file : in Unbounded_String; input_pgm : out image_record; is_found : in out boolean) is

      i : integer := 0;
      j, k : integer := 1;

      infp : file_type;

      -- Variable used for checking if the input file exists
      is_invalid : boolean := false;

   begin

      input_pgm.width := 1;
      input_pgm.height := 1;

      -- Error check if file exists using an exception to ensure program does not crash due to a name_error
      begin
         open(infp, in_file, to_string(read_pgm_file));
      exception
         when name_error => is_found := false;
      end;

      -- If the file exists, read file information into record
      if is_found /= false then

         loop
            
            -- Exit loop when all file data is read
            if i > 2 then
               if i = input_pgm.width * input_pgm.height + 4 then
                  exit;
               end if;
            end if;

            -- Read magic identifier, width, height, maximum value and pixel values in file, using an exception to ensure program does not crash due to a data_error
            if i = 0 then
               begin
                  get(infp, input_pgm.id);
               exception
                  when data_error => is_invalid := true;
               end;
            elsif i = 1 then
               begin
                  get(infp, input_pgm.width);
               exception
                  when data_error => is_invalid := true;
               end;
               if input_pgm.width > 500 then
                  is_invalid := true;
                  exit;
               end if;
            elsif i = 2 then
               begin
                  get(infp, input_pgm.height);
               exception
                  when data_error => is_invalid := true;
               end;
               if input_pgm.height > 500 then
                  is_invalid := true;
                  exit;
               end if;
            elsif i = 3 then
               begin
                  get(infp, input_pgm.max_val);
               exception
                  when data_error => is_invalid := true;
               end;
               if input_pgm.max_val /= 255 then
                  is_invalid := true;
                  exit;
               end if;
            else
               begin
                  get(infp, input_pgm.values(j,k));
               exception
                  when data_error => is_invalid := true;
               end;
               j := j + 1;
            end if;

            -- If end of line, then reset variables to read the next line of pixel values
            if i > 2 then
               if j = input_pgm.width+1 then
                  j := 1;
                  k := k + 1;
               end if;
            end if;

            i := i + 1;
         end loop;

      end if;

      -- If data_error was found set magic identifier to "--" to signal error to user
      if is_invalid /= false then
         input_pgm.id := "--";
      end if;

      if is_open(infp) then
         close(infp);
      end if;
      
   end readPGM;

   -- This procedure takes a record as input and writes the information to a file in a P2 PGM format
   procedure writePGM(write_pgm_file : in Unbounded_String; input_pgm : in image_record) is

      outfp : file_type;
      infp : file_type;

      i, user_input_int : integer := 0;
      j, k : integer := 1;

      buffer : unbounded_string;

      -- Variable used for checking if the output file already exists
      is_found : boolean := true;

   begin

      -- Error check if file exists using an exception to ensure program does not crash due to a name_error
      begin
         open(infp, in_file, to_string(write_pgm_file));
         close(infp);
      exception
         when name_error => is_found := false;
      end;

      -- If no file was found create a new file and write the record data to the file in P2 PGM format
      if is_found = false then
         create(outfp, out_file, to_string(write_pgm_file));

         set_output(outfp);

         loop
            
            -- Exit loop when all file data is read
            if i > 2 then
               if i = input_pgm.width * input_pgm.height + 4 then
                  exit;
               end if;
            end if;

            -- Write the magic identifier, width, height, maximum value and pixel values to the file
            if i = 0 then
               put(input_pgm.id); new_line;
            elsif i = 1 then
               put(input_pgm.width, Width => 0);
               put(" ");
            elsif i = 2 then
               put(input_pgm.height, Width => 0); new_line;
            elsif i = 3 then
               put(input_pgm.max_val, Width => 0); new_line;
            else
               put(input_pgm.values(j,k), Width => 0);
               put(" ");
               j := j + 1;
            end if;

            -- If end of line, then reset variables to read the next line of pixel values
            if i > 2 then
               if j = input_pgm.width+1 then
                  j := 1;
                  k := k + 1;
                  new_line;
               end if;
            end if;

            i := i + 1;
         end loop;

         close(outfp);
         set_output(standard_output);
         put_line("File write successful");

      -- If the file is found, prompt the user if they would like to overwite the file or not
      else

         put_line("");
         put_line("Error: This file already exists. Would you like to overwrite the file called: " & to_string(write_pgm_file));
         put_line("1. Yes overwite the file");
         put_line("2. No do not overwrite the file");
         put_line("Choice?");
         put_line("?"); new_line;

         -- Error check for user input using an exception to ensure program does not crash due to a data_error
         begin
            get(user_input_int);
         exception
            when data_error => user_input_int := 0;
         end;
         get_line(buffer);

         -- While the user does not enter either option 1 or 2, continuously prompt them until they select a valid option
         while user_input_int <= 0 or user_input_int >= 3 loop
            put_line("Invalid input: Please enter a number corresponding to a feature from the menu above: ");
            begin
               get(user_input_int);
            exception
               when data_error => user_input_int := 0;
            end;
            get_line(buffer);
         end loop;

         -- If the user chooses to overwrite the file write the record data to the file in P2 PGM format
         if user_input_int = 1 then
            open(outfp, out_file, to_string(write_pgm_file));

            set_output(outfp);

            loop
               
               -- Exit loop when all file data is read
               if i > 2 then
                  if i = input_pgm.width * input_pgm.height + 4 then
                     exit;
                  end if;
               end if;

               -- Write the magic identifier, width, height, maximum value and pixel values to the file
               if i = 0 then
                  put(input_pgm.id); new_line;
               elsif i = 1 then
                  put(input_pgm.width, Width => 0);
                  put(" ");
               elsif i = 2 then
                  put(input_pgm.height, Width => 0); new_line;
               elsif i = 3 then
                  put(input_pgm.max_val, Width => 0); new_line;
               else
                  put(input_pgm.values(j,k), Width => 0);
                  put(" ");
                  j := j + 1;
               end if;

               -- If end of line, then reset variables to read the next line of pixel values
               if i > 2 then
                  if j = input_pgm.width+1 then
                     j := 1;
                     k := k + 1;
                     new_line;
                  end if;
               end if;

               i := i + 1;
            end loop;

            close(outfp);
            set_output(standard_output);
            put_line("File write successful");

         -- If the user selects 2, the data will not be written to the file and the user will be brought back to the main menu
         else

            put_line("You will be brought back to the main selection menu...");
 
         end if;

      end if;

   end writePGM;

end imagepgm;
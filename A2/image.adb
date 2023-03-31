-- Name: Carson Mifsud
-- Student Number: 1089936
-- Email: cmifsud@uoguelph.ca
-- Assignment Number: 2
-- Date: March 4, 2022

-- Description: This program is a main "wrapper" program which allows the user to interact with the imagepgm 
-- and imageprocess packages, read in images, manipulate them, and write them to a file. This program includes 
-- a subprogram called getFilename which gets the username for the file to be read or written from the user

with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with imagepgm; use imagepgm;
with imageprocess; use imageprocess;

-- This main "wrapper" program allows the user to interact with the imagepgm and imageprocess packages, read in images, manipulating them, and write them to a file
procedure image is

   max, min, user_input_int : integer := 0;
   buffer, pgm_filename : unbounded_string;
   operation : string(1..1);

   -- Variable used for checking several errors
   is_read : boolean := false;
   is_processed : boolean := false;
   is_found : boolean := true;
   is_value : boolean := false;
   is_range : boolean := false;

   input_pgm : image_record;
   processing_pgm : image_record;
   histeq : hist;

   -- This procedure gets the username for the file to be read or written from the user
   procedure getFilename(operation : in string; pgm_filename : out Unbounded_String) is

   begin

      -- If the "r" flag is used then prompt the user for the file to read in
      if operation = "r" then
         put_line("Please enter a filename to read in (including the extension): ");
         get_line(pgm_filename);
      -- else prompt the user to enter the file to be written to
      else
         put_line("Please enter a filename to write to (including the extension): ");
         get_line(pgm_filename);
      end if;

   end getFilename;

begin

   put_line("");
   put_line("       Image Processing");
   put_line("1. Read in PGM image from file");
   put_line("2. Apply image inversion");
   put_line("3. Apply LOG function");
   put_line("4. Apply contrast stretching");
   put_line("5. Apply histogram equalization");
   put_line("6. Write PGM image to file");
   put_line("7. Quit");
   put_line("Choice?");
   put_line("?"); new_line;

   -- Error check for user input using an exception to ensure program does not crash due to a data_error
   begin
      get(user_input_int);
   exception
      when data_error => user_input_int := 0;
   end;
   get_line(buffer);

   -- While the user does not enter an option from 1 to 7, continuously prompt them until they select a valid option
   while user_input_int <= 0 or user_input_int >= 8 loop
      put_line("Invalid input: Please enter a number corresponding to a feature from the menu above: ");
      begin
         get(user_input_int);
      exception
         when data_error => user_input_int := 0;
      end;
      get_line(buffer);
   end loop;

   -- Loop the main menu until the user selects 7 to exit the program
   while user_input_int /= 7 loop

      -- Option 1 for reading in a PGM image from a file
      if user_input_int = 1 then

         is_found := true;

         -- Prompt the user for the file name
         operation := "r";
         getFilename(operation, pgm_filename);

         readPGM(pgm_filename, input_pgm, is_found);

         -- If the input file is not valid
         if is_found /= false then

            -- Error checking for incorrect file format
            if input_pgm.id /= "P2" then
               if input_pgm.id = "--" then
                  if input_pgm.width > 500 then
                     put_line("File Not Read: File exceeds the maximum width possible");
                     is_read := false;
                  elsif input_pgm.height > 500 then
                     put_line("File Not Read: File exceeds the maximum height possible");
                     is_read := false;
                  else
                     put_line("File Not Read: Incorrect file format");
                     is_read := false;
                  end if;
               -- Error checking for magic identifier
               else
                  put_line("File Not Read: Incorrect magic identifier");
                  is_read := false;
               end if;
            else

               -- Checking if the maximum value is 255, as 8-bit images are assumed
               if input_pgm.max_val /= 255 then
                  put_line("File Not Read: Incorrect maximum value for 8-bit image");
                  is_read := false;
               else
                  is_read := true;
                  put_line("File read in successfully");
               end if;
            end if;

         else
            is_read := false;
            put_line("Invalid File Name: The inputted file cannot be found");
         end if;
         is_processed := false;

      -- Apply image inversion
      elsif  user_input_int = 2 then

         -- If a file has been read, perform the inversion
         if is_read /= false then
            imageinv(input_pgm, processing_pgm);
            is_processed := true;
            put_line("The image inversion was successful");
         -- If no file has been read, prompt the user they must first read in a file
         else
            put_line("No File Read: You must read in a PGM file before attempting to perform an image processing function");
         end if;

      -- Apply LOG function
      elsif  user_input_int = 3 then

         -- If a file has been read, perform the LOG function
         if is_read /= false then
            imagelog(input_pgm, processing_pgm);
            is_processed := true;
            put_line("The image logarithmic transformation was successful");
         -- If no file has been read, prompt the user they must first read in a file
         else
            put_line("No File Read: You must read in a PGM file before attempting to perform an image processing function");
         end if;

      -- Apply contrast stretching
      elsif  user_input_int = 4 then

         -- If a file has been read, perform the LOG function
         if is_read /= false then

            -- Prompt user for minimum value
            put_line("Please enter the minimum intensity value you wish to use: ");

            -- Error check for user input using an exception to ensure program does not crash due to a data_error
            begin
               get(min);
               -- Error check for minimum value being out of range
               while min < 0 or min > 255 loop
                  put_line("Out of Range: Please enter the minimum intensity value you wish to use: ");
                  get(min);
                  get_line(buffer);
                  is_range := true;
               end loop;
            exception
               when data_error => is_value := true;
            end;
            if is_range = false then
               get_line(buffer);
            end if;
            is_range := false;

            -- While the user does not enter a valid number, continuously prompt them until they enter a valid number
            while is_value /= false loop
               is_value := false;
               put_line("Invalid input: Please enter the minimum intensity value you wish to use: ");
               begin
                  get(min);
                  -- Error check for minimum value being out of range
                  while min < 0 or min > 255 loop
                     put_line("Out of Range: Please enter the minimum intensity value you wish to use: ");
                     get(min);
                     get_line(buffer);
                     is_range := true;
                  end loop;
               exception
                  when data_error => is_value := true;
               end;
               if is_range = false then
                  get_line(buffer);
               end if;
               is_range := false;
            end loop;

            -- Prompt user for maximum value
            put_line("Please enter the maximum intensity value you wish to use: ");

            -- Error check for user input using an exception to ensure program does not crash due to a data_error
            begin
               get(max);
               -- Error check for maximum value being out of range
               while max < 0 or max > 255 loop
                  put_line("Out of Range: Please enter the maximum intensity value you wish to use: ");
                  get(max);
                  get_line(buffer);
                  is_range := true;
               end loop;
            exception
               when data_error => is_value := true;
            end;
            if is_range = false then
               get_line(buffer);
            end if;
            is_range := false;

            -- While the user does not enter a valid number, continuously prompt them until they enter a valid number
            while is_value /= false loop
               is_value := false;
               put_line("Invalid input: Please enter the maximum intensity value you wish to use: ");
               begin
                  get(max);
                  -- Error check for maximum value being out of range
                  while max < 0 or max > 255 loop
                     put_line("Out of Range: Please enter the maximum intensity value you wish to use: ");
                     get(max);
                     get_line(buffer);
                     is_range := true;
                  end loop;
               exception
                  when data_error => is_value := true;
               end;
               if is_range = false then
                  get_line(buffer);
               end if;
               is_range := false;
            end loop;

            imagestretch(input_pgm, min, max, processing_pgm);
            is_processed := true;
            put_line("The image contrast-stretching was successful");

         -- If no file has been read, prompt the user they must first read in a file
         else
            put_line("No File Read: You must read in a PGM file before attempting to perform an image processing function");
         end if;

      -- Apply histogram equalization
      elsif  user_input_int = 5 then

         -- If a file has been read, perform the histogram equalization
         if is_read /= false then

            for i in 1..256 loop
               histeq(i) := 0;
            end loop;

            makeHIST(input_pgm, histeq);
            histEQUAL(input_pgm, histeq, processing_pgm);
            is_processed := true;
            put_line("The image histogram equalization was successful");

         -- If no file has been read, prompt the user they must first read in a file
         else
            put_line("No File Read: You must read in a PGM file before attempting to perform an image processing function");
         end if;

      -- Write PGM image to a file
      elsif  user_input_int = 6 then

         -- If an image has been processed, write the PGM image to a file
         if is_processed /= false then

            operation := "w";
            getFilename(operation, pgm_filename);

            writePGM(pgm_filename, processing_pgm);
            is_processed := true;

         -- If no image has been processed, prompt the user they must first process an image before writing to a file
         else
            put_line("No Image Processing Function Used: You must read in a file and use an image processing function in order to write a PGM image to a file");
         end if;

      end if;

      put_line("");
      put_line("       Image Processing");
      put_line("1. Read in PGM image from file");
      put_line("2. Apply image inversion");
      put_line("3. Apply LOG function");
      put_line("4. Apply contrast stretching");
      put_line("5. Apply histogram equalization");
      put_line("6. Write PGM image to file");
      put_line("7. Quit");
      put_line("Choice?");
      put_line("?"); new_line;

      -- Error check for user input using an exception to ensure program does not crash due to a data_error
      begin
         get(user_input_int);
      exception
         when data_error => user_input_int := 0;
      end;
      get_line(buffer);

      -- While the user does not enter an option from 1 to 7, continuously prompt them until they select a valid option
      while user_input_int <= 0 or user_input_int >= 8 loop
         put_line("Invalid input: Please enter a number corresponding to a feature from the menu above: ");
         begin
            get(user_input_int);
         exception
            when data_error => user_input_int := 0;
         end;
         get_line(buffer);
      end loop;

   end loop;

   -- End of the program
   put_line("Thank you for using the Image Processing Program!");

end image;
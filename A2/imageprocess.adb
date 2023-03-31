-- Name: Carson Mifsud
-- Student Number: 1089936
-- Email: cmifsud@uoguelph.ca
-- Assignment Number: 2
-- Date: March 4, 2022

-- Description: This program contains the procedures for the imageprocess package, which includes a 
-- series of image processing algorithms, implemented as procedures

with ada.Numerics.Elementary_Functions; use ada.Numerics.Elementary_Functions;

-- This package includes a series of image processing algorithms, implemented as procedures
package body imageprocess is

   -- Performs an image inversion, takes in read record data, and record to be outputted with new data
   procedure imageINV(input_pgm : in image_record; processing_pgm : out image_record) is

   i : integer := 0;
   j, k : integer := 1;

   begin

      -- Write new data to a second record to avoid overlapping the original record
      loop
         
         -- Exit loop when all data has been processed
         if i > 2 then
            if i = input_pgm.width * input_pgm.height + 4 then
               exit;
            end if;
         end if;

         if i = 0 then
            processing_pgm.id := input_pgm.id;
         elsif i = 1 then
            processing_pgm.width := input_pgm.width;
         elsif i = 2 then
            processing_pgm.height := input_pgm.height;
         elsif i = 3 then
            processing_pgm.max_val := input_pgm.max_val;
         else
            -- Perform the formula on each pixel in the file
            processing_pgm.values(j,k) := abs(255-input_pgm.values(j,k));

            -- Checking to make sure values are not below 0 , if so change to 0
            if processing_pgm.values(j,k) < 0 then
               processing_pgm.values(j,k) := 0;
            end if;

            -- Checking to make sure values are not above 255 , if so change to 255
            if processing_pgm.values(j,k) > 255 then
               processing_pgm.values(j,k) := 255;
            end if;

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
      
   end imageINV;

   -- Performs a logarithmic transformation, takes in read record data, and record to be outputted with new data
   procedure imageLOG(input_pgm : in image_record; processing_pgm : out image_record) is

      i : integer := 0;
      current : float := 0.0;

      j, k : integer := 1;

   begin

      -- Write new data to a second record to avoid overlapping the original record
      loop

         -- Exit loop when all data has been processed   
         if i > 2 then
            if i = input_pgm.width * input_pgm.height + 4 then
               exit;
            end if;
         end if;

         if i = 0 then
            processing_pgm.id := input_pgm.id;
         elsif i = 1 then
            processing_pgm.width := input_pgm.width;
         elsif i = 2 then
            processing_pgm.height := input_pgm.height;
         elsif i = 3 then
            processing_pgm.max_val := input_pgm.max_val;
         else
            -- Perform the formula on each pixel in the file (Natural log function, base e)
            current := Float(input_pgm.values(j,k));
            processing_pgm.values(j,k) := Integer(log(current) * 255.0/log(255.0));

            -- Checking to make sure values are not below 0 , if so change to 0
            if processing_pgm.values(j,k) < 0 then
               processing_pgm.values(j,k) := 0;
            end if;

            -- Checking to make sure values are not above 255 , if so change to 255
            if processing_pgm.values(j,k) > 255 then
               processing_pgm.values(j,k) := 255;
            end if;

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
      
   end imageLOG;

   -- Performs a contrast-stretching, takes in read record data, the minimum and maximum values to be used, and record to be outputted with new data
   procedure imageSTRETCH(input_pgm : in image_record; min : in integer; max : in integer; processing_pgm : out image_record) is

      i : integer := 0;
      numerator, total, denominator : float := 0.0;
      j, k : integer := 1;

   begin
   
      -- Write new data to a second record to avoid overlapping the original record
      loop
         
         -- Exit loop when all data has been processed
         if i > 2 then
            if i = input_pgm.width * input_pgm.height + 4 then
               exit;
            end if;
         end if;

         if i = 0 then
            processing_pgm.id := input_pgm.id;
         elsif i = 1 then
            processing_pgm.width := input_pgm.width;
         elsif i = 2 then
            processing_pgm.height := input_pgm.height;
         elsif i = 3 then
            processing_pgm.max_val := input_pgm.max_val;
         else
            -- Perform the formula on each pixel in the file
            numerator := Float(input_pgm.values(j,k)) - Float(min);
            denominator := Float(max) - Float(min);
            total := numerator/denominator;
            processing_pgm.values(j,k) := Integer(255.0 * total);

            -- Checking to make sure values are not below 0 , if so change to 0
            if processing_pgm.values(j,k) < 0 then
               processing_pgm.values(j,k) := 0;
            end if;

            -- Checking to make sure values are not above 255 , if so change to 255
            if processing_pgm.values(j,k) > 255 then
               processing_pgm.values(j,k) := 255;
            end if;

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
      
   end imageSTRETCH;

   -- Calculates a histogram of an image, takes in read record data, returning the histogram ID array
   procedure makeHIST(input_pgm : in image_record; histeq : out hist) is

      i : integer := 0;
      j, k : integer := 1;

   begin

      for i in 1..256 loop
         histeq(i) := 0;
      end loop;

      -- Calculates a histogram of an image
      loop
         
         -- Write new data to a second record to avoid overlapping the original record
         if i > 2 then
            if i = input_pgm.width * input_pgm.height + 4 then
               exit;
            end if;
         end if;

         if i > 3 then
            histeq(input_pgm.values(j,k)) := histeq(input_pgm.values(j,k)) + 1;
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

   end makeHIST;

   -- Performs the histogram equalization of an image I to enhance the image, takes in read record data, histogram array, and record to be outputted with new data
   procedure histEQUAL(input_pgm : in image_record; histeq : in out hist; processing_pgm : out image_record) is

      i : integer := 0;
      total : float := 0.0;
      j, k : integer := 1;

      pdf: array(1..256) of float;
      ch: array(1..256) of float;

   begin

      -- Calculate the probability density function
      total := Float(input_pgm.width) * Float(input_pgm.height);
      for i in 1..256 loop
         pdf(i) := (Float(histeq(i)) / total);
      end loop;

      -- Calculate the cumulative histogram
      ch(1) := pdf(1);
      for i in 2..256 loop
         ch(i) := ch(i-1) + pdf(i);
      end loop;
      for i in 1..256 loop
         -- Multiply the cumulative histogram by 255 and round
         histeq(i) := Integer(ch(i) * 255.0);
      end loop;

      -- Map the new grayscale values from the results of the makeHIST procedure using a one-to-one correspondence
      loop
         
         -- Exit loop when all data has been processed
         if i > 2 then
            if i = input_pgm.width * input_pgm.height + 4 then
               exit;
            end if;
         end if;

         -- Write all data to the record
         if i = 0 then
            processing_pgm.id := input_pgm.id;
         elsif i = 1 then
            processing_pgm.width := input_pgm.width;
         elsif i = 2 then
            processing_pgm.height := input_pgm.height;
         elsif i = 3 then
            processing_pgm.max_val := input_pgm.max_val;
         else
            -- Mapping with one-to-one correspondence
            processing_pgm.values(j,k) := histeq(input_pgm.values(j,k));

            -- Checking to make sure values are not below 0 , if so change to 0
            if processing_pgm.values(j,k) < 0 then
               processing_pgm.values(j,k) := 0;
            end if;

            -- Checking to make sure values are not above 255 , if so change to 255
            if processing_pgm.values(j,k) > 255 then
               processing_pgm.values(j,k) := 255;
            end if;

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

   end histEQUAL;

end imageprocess;
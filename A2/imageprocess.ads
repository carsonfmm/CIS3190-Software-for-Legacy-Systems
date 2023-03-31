-- Name: Carson Mifsud
-- Student Number: 1089936
-- Email: cmifsud@uoguelph.ca
-- Assignment Number: 2
-- Date: March 4, 2022

-- Description: This program contains the procedure headers and type declarations for the imageprocess 
-- package, which includes a series of image processing algorithms, implemented as procedures

-- This package includes a series of image processing algorithms, implemented as procedures
package imageprocess is

   -- Double array to hold pixel values in a P2 PGM file
   type values_arr is array(1..502, 1..502) of integer;

   -- Array used for the histogram array (8-bit image)
   type hist is array(1..256) of integer;

   -- Record including the magic identifier, width, height, maximum value, and array the pixel values
   type image_record is
      record
         id : string(1..2);
         width : integer;
         height : integer;
         max_val : integer;
         values : values_arr;
      end record;

   -- Performs an image inversion, takes in read record data, and record to be outputted with new data
   procedure imageINV(input_pgm : in image_record; processing_pgm : out image_record);

   -- Performs a logarithmic transformation, takes in read record data, and record to be outputted with new data
   procedure imageLOG(input_pgm : in image_record; processing_pgm : out image_record);

   -- Performs a contrast-stetching, takes in read record data, the minimum and maximum values to be used, and record to be outputted with new data
   procedure imageSTRETCH(input_pgm : in image_record; min : in integer; max : in integer; processing_pgm : out image_record);

   -- Calculates a histogram of an image, takes in read record data, returning the histogram ID array
   procedure makeHIST(input_pgm : in image_record; histeq : out hist);

   -- Performs the histogram equalization of an image I to enhance the image, takes in read record data, histogram array, and record to be outputted with new data
   procedure histEQUAL(input_pgm : in image_record; histeq : in out hist; processing_pgm : out image_record);

end imageprocess;
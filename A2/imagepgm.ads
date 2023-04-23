-- Name: Carson Mifsud
-- Assignment Number: 2
-- Date: March 4, 2022

-- Description: This program contains the procedure headers for the imagepgm package, which deals with 
-- the input and output of images stored using the "P2" file format

with ada.strings.unbounded; use ada.strings.unbounded;
with imageprocess; use imageprocess;

-- This package deals with the input and output of images stored using the "P2" file format
package imagepgm is

   -- This procedure takes an input file and returns a record representing the image
   procedure readPGM(read_pgm_file : in Unbounded_String; input_pgm : out image_record; is_found : in out boolean);

   -- This procedure takes a record as input and writes the information to a file in a P2 PGM format
   procedure writePGM(write_pgm_file : in Unbounded_String; input_pgm : in image_record);

end imagepgm;

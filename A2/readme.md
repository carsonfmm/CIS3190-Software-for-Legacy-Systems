Name: Carson Mifsud
Student Number: 1089936
Email: cmifsud@uoguelph.ca
Assignment Number: 2
Date: March 4, 2022

Description image.adb: This program is a main "wrapper" program which allows the user to interact with the imagepgm 
and imageprocess packages, read in images, manipulate them, and write them to a file. This program includes 
a subprogram called getFilename which gets the username for the file to be read or written from the user

Description imagepgm.ads: This program contains the procedure headers for the imagepgm package, which deals with 
the input and output of images stored using the "P2" file format

Description imagepgm.adb: This program contains the procedures for the imagepgm package, which deals with 
the input and output of images stored using the "P2" file format

Description imageprocess.adb: This program contains the procedures for the imageprocess package, which includes a 
series of image processing algorithms, implemented as procedures

Description imageprocess.ads: This program contains the procedure headers and type declarations for the imageprocess 
package, which includes a series of image processing algorithms, implemented as procedures

Compile:
   gnatmake -Wall imagepgm.adb imageprocess.adb image.adb
Execute program:
   ./image

Assumptions:
   - File names for reading and writing have the .pgm extension
   - Assume pixel values for the file being read in are in the range of 0-255
   - The imin and imax values will not be the same number when using the contrast stretching 
   function
   - 8-bit images are assumed
   - Image processing calculations do not overlap, they will always make calculations to the 
   original file that was read in
   - The width and height are assumed to correctly represent the actual size of the array of 
   pixel values
   - No image processing or file write may take place until a file has been read in
   - No file writes are permitted until a user performs an image transformation

Error Handling:
   - When reading in the file, check the maximum value is 255 as 8-bit images are assumed
   - If there are any data errors when reading in the file, the program will not read in the 
   file and return control to the user
   - If the file does not have the magic identifier P2, the file will not be read in and control
   will be returned to the user
   - Check to ensure the imin and imax values for the contrast stretch are in range (0-255)
   - If a pixels value is ever below 0 after a calculation, change it to 0
   - If a pixels value is ever above 255 after a calculation, change it to 255
   - When reading in a file, if the height or width value is greater than 500, the file will 
   not be read in and control will be returned to the user
   - Exceptions with name errors for checking if files exist
   - Exceptions with data errors to avoid type mismatch throughout the program. This was used for user 
   input and file I/O. (See in line comments for further details)
   - If the user attempts to write to a file which already exists the program will prompt the user with 
   a confirmation message to confirm to file overwrite

Test Case:
   - The user will compile the program
   - The user will execute the program and be prompted with a menu of options to select from
   - Firstly, the user will select option 1 to read in a file
   - The user will type in a valid name of the file to be read
   - The user will select an image processing option (selections 2-5) and enter any other required input for
   the function
   - The user will select option 6 to write the PGM record to a file
   - The user will be prompted to type in the name of the file to output the PGM data to
   - The file will be successfully written to and the user will select option 7 to exit the program
   - If at any point throughout the program these steps are not to be completed in order, or invalid input
   is entered, the program has been designed to not crash and provide feedback to the user to instruct them the 
   correct credentials to input to successfully utilize the program

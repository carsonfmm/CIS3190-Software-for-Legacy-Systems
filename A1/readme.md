
Assignment Number: 4
Date: April 8, 2022

Description: This program takes a user-entered number of digits to be calculated for e, and saves the value of e calculated in an ASCII file which is entered by the user.

Compile calce.c:
   gcc -std=c99 -lm -Wall calce.c
Execute calce.c:
   ./a.out

Compile calce.f95:
   gfortran -Wall -fcheck=mem calce.f95
Execute calce.f95:
   ./a.out

Compile calce.adb:
   gnatmake -Wall calce.adb
Execute calce.adb:
   ./calce

Compile/Execute calce.py:
   python3 -Wall calce.py

Assumptions:
   - A maximum of 2000 may be entered for the number of digits to be calculated for e.
   - The user is expected to enter the correct data type into the significant digit prompt (i.e. integer only).
   - The format of the output file is identical to the test file (test800.txt) provided via the CourseLink discussion board "Assignments - Supplemental Info and Files". This format consists of the calculated e value up to the specified number of significant digits, followed by a newline character.
   - If the entered output file does not exist in the current working directory, the programs will create a new file with the specified name and write the correct output.
   - If the entered output file already exists in the current working directory it will be overwritten.
   - Each program follows a 3-4 spacing indentation format.

Innovation:
   - The number of significant digits must be greater than 2. If not, the several programs have implemented functionality to continuously prompt the user for a number greater than two until the integer is valid.
   - Excellent documentation and legibility for each program.
   - Increased accessibility by outputting the language each program is written in to the terminal, to inform the user which program they are using.

Limitations:
   - Output file name may have a maximum character count of 2000.

Error Handling:
   - 

Test Case:
   - The user will compile and execute the program of their choice.
   - The program will prompt the user with a welcome message stating the program name, and the language it is written in.
   - The user will be prompted to enter the number of significant digits to be calculated for e. This value must be greater than 2, if not the user will be continuously prompted until an integer greater then 2 is inputted.
   - The user will then be prompted to enter the name of the file in which to store the value of e calculated.
   - The value of e calculated will be written to the file and a message will display to the terminal if the file write has been successful.
   - The program ends.

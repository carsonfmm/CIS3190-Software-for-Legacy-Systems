Name: Carson Mifsud
Student Number: 1089936
Email: cmifsud@uoguelph.ca
Assignment Number: 3
Date: March 25, 2022

Description: This program is a modern Cobol program that performs ISBN validation on a series of 10-digit ISBNs stored 
in a user-inputted file.

Compile:
   cobc -free -x -Wall isbn.cob
Execute program:
   ./isbn

Assumptions:
   - Output is to be displayed in the terminal
   - Four space indentation was used for this program
   - Function names were changed to be lowercase as the rubric requested no UPPERCASE letters unless necessary
   - According to discussions on CourseLink: maximum 50 ISBN codes used in a file for testing

Limitations:
   - Input file name has a maximum character count of 100
   - The filler for each line in the file will ignore the next 100 characters after the first 10 characters

Error Handling:
   - The user will continuously be prompted to enter the name of a file until the file is found in the current working directory

Test Case:
   - The user will compile the program
   - The user will execute the program and be prompted to enter the name of an ASCII file until the file name is valid
   - The program will read the first 10 digits on each line in the file (Ignoring the next 100 characters on that line 
   using a filler) for each ISBN code and print out its validity to the terminal
   - The display messages are almost identical to that provided in the Assignment 3 description via CourseLink, with some 
   additional spacing for increased legibility

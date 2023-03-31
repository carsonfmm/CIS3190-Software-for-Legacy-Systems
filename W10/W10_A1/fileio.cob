identification division.
program-id. fileio_arrays.

environment division.
input-output section.
file-control.
select ifile assign to "student.dat".

data division.

file section.
fd ifile
    record contains 88 characters.

*> Specify the structure of the records in the file
*> In this case there are 4 records, each containing two elements

01 student-info.
    05 student-name occurs 4 times.
        10 stdnt-name pic x(15).
        10 stdnt-idno pic x(7).

working-storage section.
*> Define the loop index
01 i pic 9.

procedure division.
*> Open the file, read in the data into the
*> structure and close the file
    open input ifile.
    read ifile
    end-read.
    close ifile.
    move 1 to i.
*> Loop four times
    perform print-out
        until i is greater than 4.
stop run.

print-out.
    display "Student name is " stdnt-name(i).
    add 1 to i.

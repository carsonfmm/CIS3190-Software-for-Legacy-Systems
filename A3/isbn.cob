*> Name: Carson Mifsud
*> Assignment Number: 3
*> Date: March 25, 2022

*> Description: This program is a modern Cobol program that performs isbn validation on a series of 10-digit isbns stored 
*> in a user-inputted file.

identification division.
program-id. isbn-validation.

environment division.
input-output section.
file-control.
select ifile assign to ascii-file
    organization is line sequential.

data division.

file section.
fd ifile.

*> Record to hold isbn code and 100 character buffer
01 isbn.
    05 isbn-code pic x(10).
    05 filler pic x(100).

working-storage section.
01 i pic 999.
01 j pic 99.
01 valid-code pic 9.
01 last-conv pic S999.
01 first-conv pic S999.
01 rem-check pic 99.
01 last-val-check pic 999.
01 total-div pic 9999999999.
01 total pic 9999999999.
01 ascii-file pic x(100).
77 eof-check pic 9 value 1.

procedure division.

    perform read-isbn.
    display " ".

stop run.

*> Extracts the individual digits, and calculates the check-sum digit
check-sum.

    perform check-sum-total
        until j is > 9.

    compute total-div = total / 11.
    compute rem-check = 11 - (total - (total-div * 11)).

    compute total = 0.

*> Extracts the individual digits to calculate the total
check-sum-total.

    *> Converts the character to a numeric value
    compute last-conv = function numval (isbn-code(j:1)).
    
    compute total = total + (last-conv * (10 - (j - 1)) ).
    compute j = j + 1.

*> Checks the validity of the isbn
is-valid.

    read ifile
        at end move zero to eof-check
    end-read.

    if eof-check is not = zero

        compute j = 1.
        compute rem-check = 0.
        perform check-sum.

        compute j = 1.
        compute valid-code = 0.
        perform valid-check
            until j is > 10.

        *> Check for other characters other than an x/X in the last digit
        compute last-conv = function ord (isbn-code(10:1)).
        compute last-conv = last-conv - 1.

        *> Conversion for the first digit in the isbn code
        compute first-conv = function ord (isbn-code(1:1)).
        compute first-conv = first-conv - 1.

        *> If last character in the isbn code is not x/X, set valid-code to 2
        if last-conv is not = 88 or last-conv is not = 120
            if last-conv < 48 or last-conv > 57
                compute valid-code = 2
            end-if
        end-if.

        *> If the last character in the isbn code is x/X
        if last-conv = 88 or last-conv = 120
            compute valid-code = 0
        end-if.

        compute last-val-check = last-conv - 48.

        if rem-check = 11
            compute rem-check = 0
        end-if.

        if last-val-check = 40 or last-val-check = 72
            compute last-val-check = 10
        end-if.

        *> Displaying validity and information of isbn code to terminal
        if isbn-code > spaces
            if valid-code = 1
                display isbn-code"  incorrect, contains a non-digit"
            end-if

            if valid-code = 2
                display isbn-code"  incorrect, contains a non-digit/X in check digit"
            end-if

            if last-conv = 88 and first-conv = 48 and rem-check = last-val-check
                display isbn-code"  correct and valid with leading zero, trailing uppercase X"
            else if last-conv = 120 and first-conv = 48 and rem-check = last-val-check
                display isbn-code"  correct and valid with leading zero, trailing lowercase X"
            else if last-conv = 48 and first-conv = 48 and rem-check = last-val-check
                display isbn-code"  correct and valid with leading and trailing zero"
            else if last-conv = 120 and rem-check = last-val-check
                display isbn-code"  correct and valid with trailing lowercase X"
            else if last-conv = 88 and rem-check = last-val-check
                display isbn-code"  correct and valid with trailing uppercase X"
            else if last-conv = 48 and rem-check = last-val-check
                display isbn-code"  correct and valid with trailing zero"
            else if first-conv = 48 and rem-check = last-val-check
                display isbn-code"  correct and valid with leading zero"
            else if valid-code = 0
                if rem-check = last-val-check
                    display isbn-code"  correct and valid"
                else
                    display isbn-code"  correct, but not valid (invalid check digit)"
            end-if
        end-if

        *> Resetting string to be blank
        move " " to isbn

    end-if.

*> Check for any character other than a number in the isbn code (0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
valid-check.

    if valid-code = 0

        *> Converts character to decimal ascii value
        compute last-conv = function ord (isbn-code(j:1))
        compute last-conv = last-conv - 1

        if last-conv >= 48 and last-conv <= 57
            compute valid-code = 0
        else
            *> If there is another character other than a number, set the valid-code to 1
            compute valid-code = 1
        end-if

    end-if.

    compute j = j + 1.

*> Prompts the user for the name of an ascii file containing the list of isbn numbers
read-isbn.

    perform file-check.
    
    display " ".
    open input ifile.

    compute i = 1
    perform is-valid
        until eof-check = 0.

    close ifile.

*> Prompt the user for the name of an ascii file until the input file is valid
file-check.

    display "Please enter the name of an ascii file containing the list of isbn numbers: ".
    accept ascii-file.

    call "CBL_CHECK_FILE_EXIST" using ascii-file isbn.
    if return-code is not = 0
        display "File Error: The inputted file does not exist"
        perform file-check
            until return-code = 0
    end-if.

identification division.
program-id. reengineeringC.

environment division.

data division.
working-storage section.
01 rrr pic S999V99999.
01 userinput pic 9.

procedure division.

    display "Enter r: ".
    accept rrr.

    loop-1.
        compute rrr = rrr * 2.
        display "The monthly payment is: " rrr " ".
        display "Continue? (1) Anything else ends program".
        accept userinput.

    perform loop-1
        until userinput is not equal to 1

stop run.

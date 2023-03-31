identification division.
program-id. reengineeringC.

environment division.

data division.
working-storage section.
01 valuea pic S999V99999.
01 interest pic 9V99.
01 total pic S999V99999.

procedure division.

    loop-1.
        display "Enter the valuea: ".
        accept valuea.

    perform loop-1
        until valuea is less than 1

    display "Enter the interest: ".
    accept interest.

    compute total = valuea * (1+interest).

    display "The monthly payment is: " total " ".

stop run.

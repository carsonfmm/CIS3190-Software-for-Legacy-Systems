identification division.
program-id. reengineeringC.

environment division.

data division.
working-storage section.
01 total pic S999999999V99999.
01 WS-WORK2 pic S9V99999.
01 i pic 99.
01 card-num pic x(9).

procedure division.

    display "Enter the cardnum: ".
    accept card-num.

    compute i = i + 1.

    loop-1.
        COMPUTE WS-WORK2 = FUNCTION NUMVAL (card-num(i:1)).
        compute total = total + (WS-WORK2 * i).
        display "The i i is: " total " ".
        compute i = i + 1.

    perform loop-1
        until i is equal to 10

    COMPUTE WS-WORK2 = FUNCTION NUMVAL (card-num(9:1)).
    compute total = total - (WS-WORK2 * 9).
    display "The card total is: " card-num " ".
    display "The card total is: " total " ".

stop run.

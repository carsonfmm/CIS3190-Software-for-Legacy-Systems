identification division.
program-id. reengineeringC.

environment division.

data division.
working-storage section.
01 loanP pic 999V99999.
01 iRate pic 99V99999.
01 term pic 99.
01 monthlyP pic 999V99999.
01 tRate pic 9.

procedure division.
    display "Principal amount of the loan: ".
    accept loanP.
    display "Interest rate (%%): ".
    accept iRate.
    display "Loan term (months): ".
    accept term.
    display "(1) fixed or (2) floating interest rate".
    accept tRate.

    if tRate is equal to 1 then
        add 5 to iRate.
        divide 100 into iRate giving iRate.
        divide 12 into iRate giving iRate.
    if tRate is equal to 2 then
        add 2.5 to iRate.
        divide 100 into iRate giving iRate.
        divide 12 into iRate giving iRate.

    compute monthlyP = (iRate/(1.0-((1+iRate)**(term*-1)))) * loanP.

    display "The monthly payment is: " monthlyP " ".

stop run.

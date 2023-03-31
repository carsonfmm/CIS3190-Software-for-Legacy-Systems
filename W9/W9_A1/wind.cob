identification division.
program-id. reengineeringC.

environment division.

data division.
working-storage section.
01 air pic S999V99999.
01 wind pic S99V99999.
01 wcf pic S999V99999.

procedure division.
    display "Enter the air temperature in degrees celsius: ".
    accept air.
    display "Enter the wind speed in km/h at 10 meters: ".
    accept wind.

    if air < 0 then
        compute wcf = 13.12 + 0.9*air - 3*wind
    else
        compute wcf = 0.9*air - 3*wind
    end-if.

    display "The monthly payment is: " wcf " ".

stop run.

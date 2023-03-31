identification division.
program-id. BodySurfaceArea.
environment division.
data division.
working-storage section.
01 weight pic 999V9.
01 height pic 999V9.
01 w2 pic 999V9.
01 h2 pic 999V9.
01 body-SA pic 999V99.
01 body-SAo pic ZZZ.99.
procedure division.
 display "Body Surface Area Calculator".
 display " Weight (kg)? ".
 accept weight.
 display " Height (cm)? ".
 accept height.
 compute w2 = (weight**0.425).
 compute h2 = (height**0.725).
 multiply w2 by h2 giving body-SA.
 multiply 0.007184 by body-SA.
 move body-SA to body-SAo.
       PROGRAM RADIOACTIVE

C
C   RADIOACTIVE DECAY
C
       IMPLICIT NONE

       REAL HALFLIFE, MATERIAL, TIME, DECAY, INITIALMATERIAL, TEMP

       WRITE (*, *) 'half-life: '
       READ (*, *) HALFLIFE

       WRITE (*, *) 'material: '
       READ (*, *) MATERIAL

       WRITE (*, *) 'time: '
       READ (*, *) TIME

       DECAY = ( LOG(2.0) ) / HALFLIFE

       TEMP = 2.718281828459 ** ( (-1.0) * DECAY * TIME )
       INITIALMATERIAL = MATERIAL / TEMP

       WRITE (*, *) 'Initial Material = ', INITIALMATERIAL

       END
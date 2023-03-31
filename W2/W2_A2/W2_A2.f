       PROGRAM SUN

C
C   SUN KINK
C
       IMPLICIT NONE

       REAL LENGTH, TEMPERATURE, EXPANSION, NEW_SIZE

       WRITE (*, *) 'length: '
       READ (*, *) LENGTH

       WRITE (*, *) 'temperature: '
       READ (*, *) TEMPERATURE

       EXPANSION = 11.0 * ( 10.0** ( (-1) * 6.0 ) )

       NEW_SIZE = EXPANSION * LENGTH * TEMPERATURE

       WRITE (*, 100) NEW_SIZE
100    FORMAT ( 'New Size = ', F6.4 )

       END
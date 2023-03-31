       PROGRAM WAVE

C
C   WAVE BREAKING
C   PROGRAM WILL OUTPUT WRONG BREAKER TYPE ACCORDING TO WEBSITE
C   BUT ACCORDING TO A WEBSITE IT IS THE CORRECT OUTPUT.
C
       IMPLICIT NONE

       REAL WAVE_PERIOD, WAVE_HEIGHT, BEACH_SLOPE, GRAVITY, BREAKER_TYPE
       REAL TEMP

       GRAVITY = 981

       WRITE (*, *) 'Wave period T: '
       READ (*, *) WAVE_PERIOD

       WRITE (*, *) 'Wave height Hb: '
       READ (*, *) WAVE_HEIGHT

       WRITE (*, *) 'Beach slope m: '
       READ (*, *) BEACH_SLOPE

       TEMP = GRAVITY * BEACH_SLOPE * ( WAVE_PERIOD**2 )
       BREAKER_TYPE = WAVE_HEIGHT / TEMP

       IF ( BREAKER_TYPE < 0.003 ) THEN
          WRITE (*, *) 'Surging'
       ELSE IF ( BREAKER_TYPE > 0.068 ) THEN
          WRITE (*, *) 'Spilling'
       ELSE
          WRITE (*, *) 'Plunging'
       END IF

       END
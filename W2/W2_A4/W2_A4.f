       program triangle

C      
C      Program runs
C      Program does not producer the correct result as an input of
C      c=5 and theta=50 returns a negative value for the opposite side
C
C      Most likey Math error, cos() and sin() function take radians not degrees
C      

       real :: a, b, c, theta

       write (*,*) 'Enter the length of the hypotenuse C: '
       read (*,*) c
       write (*,*) 'Enter the angle theta in degrees: '
       read (*,*) theta

       a = c * (cos(theta))
       b = c * (sin(theta))

       write (*,*) 'The length of the adjacent side is ', a
       write (*,*) 'The length of the opposite side is ', b

       end program triangle
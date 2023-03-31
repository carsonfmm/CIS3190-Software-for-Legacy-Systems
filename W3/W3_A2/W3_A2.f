       program square

C      
C      Deflection in Deck Boards
C
C      Program functionality is very basic but works
C     

       implicit none

       real :: seed, new_seed, digits(4)
C      real :: a(2), b(4)

       seed = 5555

C      b = (/1, 2, 3, 4/)
C      a = b(2:3)
C      write (*,*) 'Random number is:', a

       new_seed = midsqr(seed)

       write (*,*) 'Random number is:', new_seed

       contains

       real function midsqr(seed)

       implicit none

       real, intent(in) :: seed

       real :: digits(8), temp, new_seed

       temp = seed**2

       digits(1) = floor(temp/10000000)
       temp = temp - (digits(1) * 10000000)
       digits(2) = floor(temp/1000000)
       temp = temp - (digits(2) * 1000000)
       digits(3) = floor(temp/100000)
       temp = temp - (digits(3) * 100000)
       digits(4) = floor(temp/10000)
       temp = temp - (digits(4) * 10000)
       digits(5) = floor(temp/1000)
       temp = temp - (digits(5) * 1000)
       digits(6) = floor(temp/100)
       temp = temp - (digits(6) * 100)
       digits(7) = floor(temp/10)
       temp = temp - (digits(7) * 10)
       digits(8) = floor(temp/1)

       new_seed = (digits(3) * 1000) + (digits(4) * 100)
       new_seed = new_seed + (digits(5) * 10) + (digits(6) * 1)

       midsqr = new_seed

       end function midsqr

       end program square
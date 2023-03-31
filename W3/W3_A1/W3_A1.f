       program deflection

C      
C      Deflection in Deck Boards
C
C      Functionality of checking if deflection is valid was not incorperated
C      as it is another simple calculation and if statement. Functions and
C      subroutine works as it is supposed to though.
C     

       implicit none

       real :: b, t, e, i, l, p, d

       write (*,*) 'Enter the board width b: '
       read (*,*) b
       write (*,*) 'Enter the board thickness t: '
       read (*,*) t
       write (*,*) 'Enter the modulus of elasticity e: '
       read (*,*) e
       write (*,*) 'Enter the support span l: '
       read (*,*) l

       p = 100

       call inertia(b, t, i)

       d = deflect(i, e, l, p)

       write (*,*) 'The moment of inertia (i) is:', i
       write (*,*) 'The deflection (d) is:', d

       contains

       real function deflect(i, e, l, p)

       implicit none

       real, intent(in) :: i
       real, intent(in) :: e
       real, intent(in) :: l
       real, intent(in) :: p

       real :: d

       d = (p*(l**3))/(48*e*i)

       deflect = d

       end function deflect

       end program deflection

       subroutine inertia (b, t, i)

       implicit none

       real, intent(in) :: b
       real, intent(in) :: t
       real, intent(out) :: i

       i = (b * t**3) / 12.0

       return

       end subroutine inertia


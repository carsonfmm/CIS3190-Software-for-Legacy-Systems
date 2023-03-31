program calce

!     Name: Carson Mifsud
!     Student Number: 1089936
!     Email: cmifsud@uoguelph.ca
!     Assignment Number: 4
!     Date: April 8, 2022
   
!     Description: This program takes a user-entered number of 
!     digits to be calculated for e, and saves the value of e 
!     calculated in an ASCII file which is entered by the user.

      implicit none

      character (len=2002) :: user_input, file_name
      integer, dimension(2002) :: d
      integer :: sig_dig

      write(*, *) ''
      write(*, '(A)', advance='no') 'Calculating e to many &
     &digits in Fortran!'
      write(*, *) ''

!     Prompt user for number of significant digits
      write(*, *) ''
      write(*, '(A)', advance='no') 'Please enter the number of &
     &significant digits to calculate: '
      read(*, '(A)') user_input

!     Convert string to int
      read(user_input, *) sig_dig

!     Check to make sure user input is greater than 2, if not 
!     continuously prompt user for valid input
      do while (sig_dig < 2)
         write(*, *) ''
         write(*, '(A,/)', advance='no') 'Input Error: The number of &
     &significant digits must be greater than 2'
         write(*, '(A)', advance='no') 'Please enter the number of &
     &significant digits to calculate: '
         read(*, '(A)') user_input
    
!        Convert string to int
         read(user_input, *) sig_dig
      end do

!     Prompt user for name of the output file
      write(*, *) ''
      write(*, '(A)', advance='no') 'Please enter the name of the &
     &file in which to store the value of e calculated: '
      read(*, '(A)') file_name

      call ecalculation (sig_dig, d)
      call keepe (d, file_name, sig_dig)

      end program calce


!     This procedure for calculating the transcendental
!     number e to n correct decimal places uses only integer 
!     arithmetic, except for estimating the required series 
!     length. The digits of the result are placed in the array 
!     d, the array element d[0] containing entier(e), and the
!     subsequent elements the following digits. These digits
!     are individually calculated
      subroutine ecalculation(n, d)

         implicit none

!        intent(inout) used as arguments will receive a value from, 
!        and return a value to its corresponding actual value
         integer, intent(inout) :: n

         integer, intent(inout), dimension(2002) :: d

         integer :: m = 0
         real :: test
         integer :: i = 0
         integer :: j = 0
         integer :: carry = 0
         integer :: temp = 0
         integer, dimension(2002) :: coef

         m = 4
         test = (n + 1.0) * 2.30258509

!        Calculate number of required indices
         do while ((m * (log(real(m)) - 1.0)) + (0.5 * &
       & (log(6.2831852 * real(m)))) < test)
            m = m + 1;
         end do

!        Initialize required indices in coef
         j = 2
         do while (j /= m)
            coef(j) = 1
            j = j + 1
         end do

!        Calculate digits of e
         d(1) = 2
         i = 1
         do while (i /= n+1)
            carry = 0
            j = int(m)-1
            do while (j /= 1)
                temp = (coef(j+1) * 10) + carry
                carry = temp / j
                coef(j+1) = temp - (carry * j)
                j = j - 1
            end do
            d(i+1) = carry
            i = i + 1
         end do

      end subroutine ecalculation

!     This subprogram saves the value of e calculated in an ASCII file.
!     It takes as input the calculated value of e, and the filename 
!     specified by the user.
      subroutine keepe(d, file_name, sig_dig)

         implicit none

!        intent(inout) used as arguments will receive a value from, 
!        and return a value to its corresponding actual value
         integer, intent(inout) :: sig_dig

         integer, intent(inout), dimension(2002) :: d
         character (len=2002), intent(inout) :: file_name

         logical :: lexist
         integer :: i = 0

!        Checking if the file is found. If found, open the file, if not
!        create and open the file
         inquire(file=file_name, exist=lexist)
         if (.not. lexist) then
            open(unit=1, file=file_name, status='new')
         else
            open(unit=1, file=file_name)
         end if

!        Write data to the file
         write(1, '(I1)', advance='no') d(1)
         write(1, '(A)', advance='no') '.'

         i = 2
         do while (i < sig_dig+1)
            write(1, '(I1)', advance='no') d(i)
            i = i + 1
         end do

         write(*, *) ''
         write(*, '(A)', advance='no') 'File write successful!'
         write(*, '(A)') '', ''

!        Close file
         close (1)

     end subroutine keepe
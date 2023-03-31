      program day
!     This program calculates the day of year
!     corresponding to a specified date.
      implicit none
      integer :: days, day_of_year, i
      integer :: leap_year, month, year
      ! Get day, month and year
      write (*,*) 'Enter the day (1-31), month (1-12) and year'
      read (*,*) days, month, year
      day_of_year = days
!     Check for leap year, and add an extra day
      if (mod(year,400) == 0) then
         leap_year = 1
      else if (mod(year,100) == 0) then
         leap_year = 0
      else if (mod(year,4) == 0) then
         leap_year = 1
      else
         leap_year = 0
      end if
!     Calculate day of year
      do i = 1, month-1
        select case(i)
        case (1,3,5,7,8,10,12)
           day_of_year = day_of_year + 31
        case (4,6,9,11)
           day_of_year = day_of_year + 30
        case (2)
           day_of_year = day_of_year + 28 + leap_year
        end select
      end do
      write (*,100) day_of_year
  100 format ('Day of year = ', I4)
      end program day
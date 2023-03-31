       program mtbf

C      
C      Mean-Time-Between-Failure
C
C      Assume number of components for each was 1 to save time
C
C      Once again very basic and simple design but I got the idea
C      of loops and dynamically allocating and deallocating an array
C     

       implicit none

       integer :: components, hours, a
       real, dimension (:), allocatable :: darray
       real :: total

       a = 1

       write (*,*) 'Enter the number of components: '
       read (*,*) components
       write (*,*) 'Enter the number of hours to test each component: '
       read (*,*) hours

       allocate ( darray(components) )

       do
          write (*,*) 'Enter the associated failure time: '
          read (*,*) darray(a)
          a = a + 1
          if ( a == components+1 ) exit
       end do

       a = 1

       do
          total = total + darray(a)
          a = a + 1
          if ( a == components+1 ) exit
       end do

       write (*,*) 'mtbf: ', total

       deallocate (darray)

       end program mtbf
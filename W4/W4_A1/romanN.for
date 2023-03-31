      PROGRAM roman_number 

C     Input: integer
C     Output: input integer and its Roman equivalent
C     Variables: i -- input integer
C            r -- array to store Roman numeral
C            n -- current number of symbols in r

C     Hollerith characters which were replaced with an character
C     which is converted to an integer using the ICHAR function

C     computed GO TO which has been replaced by the SELECT CASE
C     structure

C     Identifiers and labels could be renamed for better readibility
      INTEGER i, r(31), n, j

      WRITE(*,*) 'Enter a year '
      READ(*,100) i
  100 FORMAT(I4)

      IF (i .LE. 0) GO TO 200
C     Start with an empty Roman numeral
      n=0
C     Convert 1000's digit, 100's digit, tens, units
      CALL digit(mod(i/1000,10), ICHAR('M'), ICHAR('W'), ICHAR('Y'),
     & r, n)
      CALL digit(mod(i/100 ,10), ICHAR('C'), ICHAR('D'), ICHAR('M'),
     & r, n)
      CALL digit(mod(i/10  ,10), ICHAR('X'), ICHAR('L'), ICHAR('C'),
     & r, n)
      CALL digit(mod(i     ,10), ICHAR('I'), ICHAR('V'), ICHAR('X'),
     & r, n)
      WRITE(*,101) i, (r(j),j=1,n)
  101 FORMAT('The Roman numeral for', I5,' is '31A1)
      STOP 

  200 WRITE(*,201) i
  201 FORMAT('No Roman numeral for',I5)
  
      STOP 
      END 

      SUBROUTINE digit(d, a, b, c, r, n)
      INTEGER d, a, b, c, r(31), n
C     Input: 
C            d -- number between 0 and 9
C            a,b,c -- Roman symbols
C            r -- array to store Roman numeral
C            n -- current number of symbols in r 
C     Output: 
C            r,n -- updated by converting d to Roman symbols 
      INTEGER case
      case = d
      select case(case)
C     input d=0, output pattern=nothing
      case(0)
        RETURN 
C     input d=1, output pattern=A
      case(1)
        r(n+1) = a
        n = n + 1
        RETURN 
C     input d=2, output pattern=AA
      case(2)
        r(n+1) = a
        r(n+2) = a
        n = n + 2
        RETURN 
C     input d=3, output pattern=AAA
      case(3)
        r(n+1) = a
        r(n+2) = a
        r(n+3) = a
        n = n + 3
        RETURN 
C     input d=4, output patter=AB
      case(4)
        r(n+1) = a
        r(n+2) = b
        n = n + 2
        RETURN 
C     input d=5, output patter=B
      case(5)
        r(n+1) = b
        n = n + 1
        RETURN 
C     input d=6, output patter=BA
      case(6)
        r(n+1) = b
        r(n+2) = a
        n = n + 2
        RETURN 
C     input d=6, output patter=BAA
      case(7)
        r(n+1) = b
        r(n+2) = a
        r(n+3) = a
        n = n + 3
        RETURN 
C     input d=6, output patter=BAAA
      case(8)
        r(n+1) = b
        r(n+2) = a
        r(n+3) = a
        r(n+4) = a
        n = n + 4
        RETURN 
C     input d=6, output patter=AC
      case(9)
        r(n+1) = a
        r(n+2) = c
        n = n + 2
         RETURN
      case default
         RETURN
      end select
      END


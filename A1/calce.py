# Name: Carson Mifsud
# Student Number: 1089936
# Email: cmifsud@uoguelph.ca
# Assignment Number: 4
# Date: April 8, 2022

# Description: This program takes a user-entered number of 
# digits to be calculated for e, and saves the value of e calculated
# in an ASCII file which is entered by the user.

import math # Math

# This procedure for calculating the transcendental
# number e to n correct decimal places uses only integer 
# arithmetic, except for estimating the required series 
# length. The digits of the result are placed in the array 
# d, the array element d[0] containing entier(e), and the
# subsequent elements the following digits. These digits
# are individually calculated
def ecalculation (n, d):

    coef = []
    coef.extend(range(2001))

    m = 4
    test = (n + 1) * 2.30258509

    # Calculate number of required indices
    while (m * (math.log(m) - 1.0) + 0.5 * math.log(6.2831852 * m) < test):
        m = m + 1

    int(m)

    # Initialize required indices in coef
    j = 0
    while j != m:
        coef[j] = 1
        j = j + 1

    # Calculate digits of e
    d[0] = 2
    i = 1
    while i != n+1:
        carry = 0
        j = m-1
        while j != 1:
            temp = int((coef[j] * 10) + carry)
            carry = int(temp / j)
            coef[j] = int(temp - (carry * j))
            j = j - 1

        d[i] = carry
        i = i + 1

# This subprogram saves the value of e calculated in an ASCII file.
# It takes as input the calculated value of e, and the filename 
# specified by the user.
def keepe (d, file_name, sig_dig):

    # Open the file for writing
    f = open(file_name, "w")

    # Write data to the file
    f.write(str(d[0]))
    f.write(".")
    i = 1
    while i < sig_dig:
        f.write(str(d[i]))
        i = i + 1
    f.write("\n")

    # Close file
    f.close()

    print ("\nFile write successful!\n")

d = []
d.extend(range(2001))

print ("\nCalculating e to many digits in Python!")

# Prompt user for number of significant digits
user_input = input("\nPlease enter the number of significant digits to calculate: ")

# Convert string to int
sig_dig = int(user_input)

# Check to make sure user input is greater than 2 if not continuously prompt user for valid input
while sig_dig < 2:
    print ("Input Error: The number of significant digits must be greater than 2\n")
    user_input = input("Please enter the number of significant digits to calculate: ")

    # Convert string to int
    sig_dig = int(user_input)

# Prompt user for name of the output file
file_name = input("\nPlease enter the name of the file in which to store the value of e calculated: ")

ecalculation (sig_dig, d)
keepe (d, file_name, sig_dig)

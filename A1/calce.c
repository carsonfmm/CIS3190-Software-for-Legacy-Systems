// Name: Carson Mifsud
// Student Number: 1089936
// Email: cmifsud@uoguelph.ca
// Assignment Number: 4
// Date: April 8, 2022

// Description: This program takes a user-entered number of 
// digits to be calculated for e, and saves the value of e calculated
// in an ASCII file which is entered by the user.

#include <stdio.h>      /* Input/Output */
#include <stdlib.h>     /* General Utilities */
#include <unistd.h>     /* Symbolic Constants */
#include <string.h>     /* String */
#include <math.h>       /* Math */
#include <ctype.h>      /* Data Types */

/*
 * This procedure for calculating the transcendental
 * number e to n correct decimal places uses only integer 
 * arithmetic, except for estimating the required series 
 * length. The digits of the result are placed in the array 
 * d, the array element d[0] containing entier(e), and the
 * subsequent elements the following digits. These digits
 * are individually calculated
 */
void ecalculation (int n, int * d) {

    int m;
    float test;

    m = 4;
    test = (n + 1) * 2.30258509;

    // Calculate number of required indices
    while (m * (log(m) - 1.0) + 0.5 * log(6.2831852 * m) < test) {
        m = m + 1;
    }

    int i = 0;
    int j = 0;
    int carry = 0;
    int temp = 0;
    int coef[m];

    // Initialize required indices in coef
    for (j = 2; j != m; j++) {
        coef[j] = 1;
    }

    // Calculate digits of e
    d[0] = 2;
    for (i = 1; i != n+1; i++) {
        carry = 0;
        for (j = m-1; j != 1; j--) {
            temp = (coef[j] * 10) + carry;
            carry = temp / j;
            coef[j] = temp - (carry * j);
        }
        d[i] = carry;
    }

}

/*
 * This subprogram saves the value of e calculated in an ASCII file.
 * It takes as input the calculated value of e, and the filename 
 * specified by the user.
 */
void keepe (int * d, char * file_name, int sig_dig) {

    FILE *fptr;
    int i = 0;

    // Open the file for writing
    fptr = fopen (file_name,"w");

    // File error check
    if (fptr == NULL) {
        printf ("\nFile Write: Error!\n\n");
        exit (1);
    }

    // Write data to the file
    fprintf (fptr, "%d.", d[0]);
    for (i = 1; i < sig_dig; i++) {
        fprintf (fptr, "%d", d[i]);
    }
    fprintf (fptr, "\n");

    printf ("\nFile write successful!\n\n");

    // Close file
    fclose (fptr);

}

/*
 * The main program calls the procedures ecalculation and keepe.
 * This program also prompts the user for the number of significant 
 * digits and the name of the file in which to store the value of
 * e calculated.
 */
int main ( int argc, char **argv ) {

    char user_input[2001];
    char file_name[2001];
    int d[2001];
    int sig_dig;
    int i;

    printf ("\nCalculating e to many digits in C!\n");

    // Prompt user for number of significant digits
    printf ("\nPlease enter the number of significant digits to calculate: ");
    fgets (user_input, 2001, stdin);

    // Convert string to int
    sig_dig = atoi(user_input);

    // Check to make sure user input is greater than 2 if not continuously prompt user for valid input
    while (sig_dig < 2) {
        printf ("\nInput Error: The number of significant digits must be greater than 2\n");
        printf ("Please enter the number of significant digits to calculate: ");
        fgets (user_input, 2001, stdin);

        // Convert string to int
        sig_dig = atoi(user_input);   
    }

    // Prompt user for name of the output file
    printf ("\nPlease enter the name of the file in which to store the value of e calculated: ");
    fgets (file_name, 2001, stdin);

	// Remove the '\n' character from file_name
	for (i = 0; file_name[i] != '\0'; i++) {}
    file_name[i-1] = '\0';

    ecalculation (sig_dig, d);
    keepe (d, file_name, sig_dig);

    return ( 0 );

}
# A Project For Tant

## Overview

Here's the project as it currently stands:

- The program will read in the file and 100% of the data, but does nothing with it.
- As soon as the data is put into FORTRAN arrays, the data is immediately thrown away.

## Compiling

It's a vanilla Fortran 95 program, so here's the compile line.

     $ gfortran ForTant.f95

## Usage

The `gfortran` compiler will output executables as the filename `a.out`. Currently, you can pass it any file along the command line. We can change this if need be.

     $ ./a.out USM00074005-data.txt

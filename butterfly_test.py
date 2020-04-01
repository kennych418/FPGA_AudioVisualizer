#!/usr/bin/python
import sys

a_real = float(sys.argv[1])
a_imag = float(sys.argv[2])
b_real = float(sys.argv[3])
b_imag = float(sys.argv[4])

for i in range(8):
    if i == 0:    
        w_real = 1
        w_imag = 0
    elif i==1:
        w_real = 0.9239
        w_imag = -0.3827
    elif i==2:
        w_real = 0.7071
        w_imag = -0.7071
    elif i==3:
        w_real = 0.3827
        w_imag = -0.9239
    elif i==4:
        w_real = 0
        w_imag = -1
    elif i==5:
        w_real = -0.3827
        w_imag = -0.9239
    elif i==6:
        w_real = -0.7071
        w_imag = -0.7071
    elif i==7:
        w_real = -0.9239
        w_imag = -0.3827

    mult_out_real = b_real * w_real - b_imag * w_imag
    mult_out_imag = b_imag * w_real + b_real * w_imag

    f0_real = a_real + mult_out_real
    f0_imag = a_imag + mult_out_imag
    f1_real = a_real - mult_out_real
    f1_imag = a_imag - mult_out_imag

    print("When w = " + str(w_real) + " " + str(w_imag))
    print("f0 = " + str(f0_real) + " " + str(f0_imag))
    print("f1 = " + str(f1_real) + " " + str(f1_imag))
    print("")
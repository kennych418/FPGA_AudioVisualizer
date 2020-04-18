module butterflyunit( 	input [47:0] A_t, input [47:0] B_t, input [47:0] W,		//47:24 real, 23:0 imag
						output [47:0] A_f, output [47:0] B_f);					//47:24 real, 23:0 imag
	
	//18 bit 2's complement signed real and imag numbers for time domain input
	//16 point FFT requires 6 extra bits for bit growth
	
	wire [47:0] A_real_B_real, A_imag_B_imag, A_imag_B_real, A_real_B_imag;	//multiplier interconnects
	wire [95:0] multout;	//95:48 real, 47:0 imag
	wire [47:0] truncated_prod;
	
	assign truncated_prod = {multout[94:71], multout[46:23]};		//range set to avoid extra sign bit that results from signed multiplication, truncation avoids unneeded LSB's
																	//23 bits truncated out, therefore W must be multiplied by 2^23 to compensate
	
	///////////Complex Adder///////////
	assign A_f[47:24] = A_t[47:24] + truncated_prod[47:24];
	assign A_f[23:0] = A_t[23:0] + truncated_prod[23:0];

	///////////Complex Substractor///////////
	assign B_f[47:24] = A_t[47:24] + (~truncated_prod[47:24] + 24'b1);
	assign B_f[23:0] = A_t[23:0] + (~truncated_prod[23:0] + 24'b1);

	///////////Complex Multiplier///////////
	assign A_real_B_real = {{24{B_t[47]}}, B_t[47:24]} * {{24{W[47]}}, W[47:24]};	//real * real
	assign A_imag_B_imag = {{24{B_t[23]}}, B_t[23:0]} * {{24{W[23]}}, W[23:0]};	//imag * imag
	assign A_imag_B_real = {{24{B_t[23]}}, B_t[23:0]} * {{24{W[47]}}, W[47:24]}; //imag * real
	assign A_real_B_imag = {{24{B_t[47]}}, B_t[47:24]} * {{24{W[23]}}, W[23:0]}; //real * imag
	assign multout[95:48] = A_real_B_real + (~A_imag_B_imag + 1);
	assign multout[47:0]  = A_imag_B_real + A_real_B_imag;

endmodule 

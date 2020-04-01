module butterflyunit( 	input [47:0] A_t, input [47:0] B_t, input [47:0] W,		//47:24 real, 23:0 imag
						output [47:0] A_f, output [47:0] B_f);					//47:24 real, 23:0 imag
	
	//18 bit 2's complement signed real and imag numbers for time domain input
	//16 point FFT requires 6 extra bits for bit growth
	
	wire [95:0] multout;			//95:48 real, 47:0 imag
	wire [47:0] truncated_prod;
	
	assign truncated_prod = {multout[94:71], multout[46:23]};		//range set to avoid extra sign bit that results from signed multiplication, truncation avoids unneeded LSB's
																	//15 bits truncated out, therefore to improve accuracy W is format b16.b15b14b13...
	complexadder topadder(				.comp_augend		(A_t), 
										.comp_addend		(truncated_prod), 
										.comp_sum			(A_f)	);
	
	complexsubtractor bottomadder(		.comp_minuend		(A_t), 
										.comp_subtrahend	(truncated_prod), 
										.comp_difference	(B_f)	);
	
	complexmultiplier twiddlemult(		.comp_multiplicand	(B_t), 
										.comp_multiplier	(W),
										.comp_product		(multout)	);
							 
endmodule 

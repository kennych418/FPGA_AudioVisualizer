module butterflyunit( input [31:0] A_t, input [31:0] B_t, input [31:0] W,		//31:16 real, 15:0 imag
							 output [31:0] A_f, output [31:0] B_f);						//31:16 real, 15:0 imag
	
	//11 bit 2's complement signed real and imag numbers
	//32 point FFT (2^5) requires 5 extra bits for bit growth
	
	wire [63:0] multout;	//63:32 real, 31:0 imag
	wire [31:0] truncated_prod;
	
	assign truncated_prod = {multout[62:47], multout[30:15]};		//range set to avoid extra sign bit that results from signed multiplication, truncation avoids unneeded LSB's
	
	complexadder topadder(				.comp_augend		(A_t), 
												.comp_addend		(truncated_prod), 
												.comp_sum			(A_f)	);
	
	complexsubtractor bottomadder(	.comp_minuend		(A_t), 
												.comp_subtrahend	(truncated_prod), 
												.comp_difference	(B_f)	);
	
	complexmultiplier twiddlemult(	.comp_multiplicand(B_t), 
												.comp_multiplier	(W),
												.comp_product		(multout)	);
							 
endmodule 

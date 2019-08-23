module complexmultiplier( input [31:0] comp_multiplicand, input [31:0] comp_multiplier, 		//31:16 real, 15:0 imag
								  output [63:0] comp_product);													//63:32 real, 31:0 imag
	
	//PASSES TESTBENCH
	
	wire [31:0] a_r_b_r, a_i_b_i, a_i_b_r, a_r_b_i;		//63:32 real, 31:0 imag
	
	simplemultiplier mult_ar_br(	.multiplicand	(comp_multiplicand[31:16]), 
											.multiplier	 	(comp_multiplier[31:16]),
											.product			(a_r_b_r)	);
	
	simplemultiplier mult_ai_bi(	.multiplicand	(comp_multiplicand[15:0]),
											.multiplier		(comp_multiplier[15:0]),
											.product			(a_i_b_i)	);
	
	simplemultiplier mult_ai_br(	.multiplicand	(comp_multiplicand[15:0]),
											.multiplier		(comp_multiplier[31:16]), 
											.product			(a_i_b_r)	);
	
	simplemultiplier mult_ar_bi(	.multiplicand	(comp_multiplicand[31:16]),
											.multiplier		(comp_multiplier[15:0]),
											.product			(a_r_b_i)	);
	
	assign comp_product[63:32] = a_r_b_r + (~a_i_b_i + 1);
	assign comp_product[31:0]  = a_i_b_r + a_r_b_i;
	
							 
endmodule 
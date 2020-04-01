module complexmultiplier( 	input [47:0] comp_multiplicand, input [47:0] comp_multiplier, 		//47:24 real, 23:0 imag
							output [95:0] comp_product);										//95:48 real, 47:0 imag
	
	wire [47:0] a_r_b_r, a_i_b_i, a_i_b_r, a_r_b_i;	
	

	simplemultiplier mult_ar_br(	.multiplicand	(comp_multiplicand[47:24]), 
											.multiplier	 	(comp_multiplier[47:24]),
											.product			(a_r_b_r)	);
	
	simplemultiplier mult_ai_bi(	.multiplicand	(comp_multiplicand[23:0]),
											.multiplier		(comp_multiplier[23:0]),
											.product			(a_i_b_i)	);
	
	simplemultiplier mult_ai_br(	.multiplicand	(comp_multiplicand[23:0]),
											.multiplier		(comp_multiplier[47:24]), 
											.product			(a_i_b_r)	);
	
	simplemultiplier mult_ar_bi(	.multiplicand	(comp_multiplicand[47:24]),
											.multiplier		(comp_multiplier[23:0]),
											.product			(a_r_b_i)	);
	
	assign comp_product[95:48] = a_r_b_r + (~a_i_b_i + 1);
	assign comp_product[47:0]  = a_i_b_r + a_r_b_i;
	
							 
endmodule 
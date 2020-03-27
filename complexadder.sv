module complexadder( input [47:0] comp_augend, input [47:0] comp_addend, 
							output [47:0] comp_sum );
	
	//PASSES TESTBENCH
	
	assign comp_sum[47:24] = comp_augend[47:24] + comp_addend[47:24];
	assign comp_sum[23:0]  = comp_augend[23:0]  + comp_addend[23:0] ;
	
							 
endmodule 
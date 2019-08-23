module complexadder( input [31:0] comp_augend, input [31:0] comp_addend, 
							output [31:0] comp_sum );
	
	//PASSES TESTBENCH
	
	assign comp_sum[31:16] = comp_augend[31:16] + comp_addend[31:16];
	assign comp_sum[15:0]  = comp_augend[15:0]  + comp_addend[15:0] ;
	
							 
endmodule 
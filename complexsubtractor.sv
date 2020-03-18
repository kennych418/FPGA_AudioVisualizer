module complexsubtractor( input [31:0] comp_minuend, input [31:0] comp_subtrahend, 
									output [31:0] comp_difference );

	//PASSES TESTBENCH
									
	assign comp_difference[31:16] = comp_minuend[31:16] + (~comp_subtrahend[31:16] + 16'b1);
	assign comp_difference[15:0 ] = comp_minuend[15:0 ] + (~comp_subtrahend[15:0 ] + 16'b1);

endmodule
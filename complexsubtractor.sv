module complexsubtractor( input [47:0] comp_minuend, input [47:0] comp_subtrahend, 
									output [47:0] comp_difference );

	//PASSES TESTBENCH
									
	assign comp_difference[47:24] = comp_minuend[47:24] + (~comp_subtrahend[47:24] + 24'b1);
	assign comp_difference[23:0 ] = comp_minuend[23:0 ] + (~comp_subtrahend[23:0 ] + 24'b1);

endmodule
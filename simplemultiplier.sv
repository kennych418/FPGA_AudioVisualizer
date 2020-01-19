module simplemultiplier( input [15:0] multiplicand, input [15:0] multiplier, 
								  output [31:0] product);
	
	reg [31:0] multiplicand_extend;
	reg [31:0] multiplier_extend;
	
	assign multiplicand_extend = {{16{multiplicand[15]}}, multiplicand[15:0]};
	assign multiplier_extend = {{16{multiplier[15]}}, multiplier[15:0]};
	assign product = multiplicand_extend * multiplier_extend;
	
endmodule 
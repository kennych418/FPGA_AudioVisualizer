module simplemultiplier( 	input [23:0] multiplicand, input [23:0] multiplier, 
							output [47:0] product);
	
	reg [47:0] multiplicand_extend;
	reg [47:0] multiplier_extend;
	
	assign multiplicand_extend = {{24{multiplicand[23]}}, multiplicand[23:0]};
	assign multiplier_extend = {{24{multiplier[23]}}, multiplier[23:0]};
	assign product = multiplicand_extend * multiplier_extend;
	
endmodule 
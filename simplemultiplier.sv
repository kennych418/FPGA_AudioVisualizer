module simplemultiplier( input [15:0] multiplicand, input [15:0] multiplier, 
								  output [31:0] product);
	
	assign product = multiplicand * multiplier;
	
endmodule 
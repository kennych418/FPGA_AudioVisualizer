module mic_translator(input clk, input DOUT, output LRCLK, output BCLK, output new_t,
							 output [9:0] t0, output [9:0] t1, output [9:0] t2, output [9:0] t3, 
							 output [9:0] t4, output [9:0] t5, output [9:0] t6, output [9:0] t7, 
							 output [9:0] t8, output [9:0] t9, output [9:0] t10, output [9:0] t11, 
							 output [9:0] t12, output [9:0] t13, output [9:0] t14, output [9:0] t15);
	
	//18 bits of data, 4MHz clock
	
	clkdiv50to4 clkdiv(clk, BCLK);
	
	reg [2:0] BCLK_counter;
	
	initial begin
		BCLK_counter = 0;
	end
	
	always @ (posedge BCLK) begin
		if (BCLK_counter < 10) begin
			BCLK_counter <= BCLK_counter + 1;
		end
		else begin
			BCLK_counter <= 0;
		end
	end
	
	assign t0 = {DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT};
	assign t1 = {DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT};
	assign t2 = {DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT};
	assign t3 = {DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT};
	assign t4 = {DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT};
	assign t5 = {DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT};
	assign t6 = {DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT};
	assign t7 = {DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT};
	assign t8 = {DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT};
	assign t9 = {DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT};
	assign t10 = {DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT};
	assign t11 = {DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT};
	assign t12 = {DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT};
	assign t13 = {DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT};
	assign t14 = {DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT};
	assign t15 = {DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT, DOUT};

endmodule
module FFT_TB;

	integer i;
	integer j;

	reg clk, reset, DOUT, LRCLK, BCLK, vsync, hsync;
	reg [3:0] r, g, b;

	FFT UUT( clk,  reset,  DOUT,  LRCLK,  BCLK, 		  
			   vsync,  hsync, r, g, b);
				
	initial begin
		DOUT = 1;
		clk = 0;
		#10;
		reset = 0;
		#10;
		for(i = 0; i < 100; i = i+1) begin
			clk = 1;
			#10;
			clk = 0;
			#10;
		end
		clk = 1;
		#10;
		reset = 1;
		#10;
		for(j = 0; j < 100; j = j + 1) begin
			for(i = 0; i < 10000; i = i+1) begin
				clk = 0;
				#10;
				clk = 1;
				#10;
			end
		end
		
		
	end

endmodule
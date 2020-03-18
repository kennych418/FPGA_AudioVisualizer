module mic_translator_TB;
	
	reg clk; reg reset; reg DOUT; reg LRCLK; reg BCLK; reg new_t;
	reg [9:0] t0; reg [9:0] t1; reg [9:0] t2; reg [9:0] t3;
	reg [9:0] t4; reg [9:0] t5; reg [9:0] t6; reg [9:0] t7; 
	reg [9:0] t8; reg [9:0] t9; reg [9:0] t10; reg [9:0] t11; 
	reg [9:0] t12; reg [9:0] t13; reg [9:0] t14; reg [9:0] t15;
	
	integer i;
	integer j;
	
	mic_translator UUT(clk, reset, DOUT,  LRCLK,  BCLK,  new_t,
							 t0, t1, t2, t3, 
							 t4, t5, t6, t7, 
							 t8, t9, t10, t11, 
							 t12,t13,t14, t15);
	
	initial begin
		clk = 0;
		DOUT = 1;
		
		reset = 1;
		#10;
		reset = 0;
		#10;
		for(i = 0; i < 8; i = i+1) begin
			for(j=0; j < 64; j=j+1) begin
				clk = ~clk;
				#10;
			end
		end
		reset = 1;
		#10;
		
		for(i = 0; i < 1000; i = i+1) begin
			for(j=0; j < 16; j=j+1) begin
				clk = ~clk;
				#10;
			end
		end
	end
	
endmodule

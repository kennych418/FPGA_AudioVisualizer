module mic_translator_TB;
	reg DOUT; reg LRCLK; reg BCLK; reg new_t;
	reg [9:0] t0; reg [9:0] t1; reg [9:0] t2; reg [9:0] t3;
	reg [9:0] t4; reg [9:0] t5; reg [9:0] t6; reg [9:0] t7; 
	reg [9:0] t8; reg [9:0] t9; reg [9:0] t10; reg [9:0] t11; 
	reg [9:0] t12; reg [9:0] t13; reg [9:0] t14; reg [9:0] t15;
	
	mic_translator UUT(DOUT,  LRCLK,  BCLK,  new_t,
							 t0, t1, t2, t3, 
							 t4, t5, t6, t7, 
							 t8, t9, t10, t11, 
							 t12,t13,t14, t15);
	
	initial begin
		
	end
	
endmodule

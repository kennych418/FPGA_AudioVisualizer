module butterflyunit_TB;
	
	logic [31:0] A_t; logic [31:0] B_t; logic [31:0] W;		//31:16 real, 15:0 imag
	logic [31:0] A_f; logic [31:0] B_f;										//31:16 real, 15:0 imag
	
	//11 bit 2's complement signed real and imag numbers
	//32 point FFT (2^5) requires 5 extra bits for bit growth
	
	butterflyunit UUT( A_t, B_t, W, A_f, B_f);
	
	initial begin
	
		A_t = 32'h03FF_0000;
		B_t = 32'h03FF_0000;
		W	 = 32'h03FF_0000;
	
		#100;
	
	end
							 
endmodule 
module butterflyunit_TB;
	
	//11 bit 2's complement signed real and imag numbers
	//32 point FFT (2^5) requires 5 extra bits for bit growth
		
	reg [15:0] A_t_real, A_t_imag, B_t_real, B_t_imag, W_real, W_imag;
	wire [15:0] A_f_real, A_f_imag, B_f_real, B_f_imag;
	
	butterflyunit UUT( {A_t_real, A_t_imag}, {B_t_real, B_t_imag}, {W_real, W_imag}, {A_f_real, A_f_imag}, {B_f_real, B_f_imag});
	
	initial begin
	
		A_t_real = 1023;
		A_t_imag = 0;
		B_t_real = 1023;
		B_t_imag = 0;
		W_real = 32'h7FFF;
		W_imag = 0;
		#100; 
		A_t_real = 1023;
		A_t_imag = 0;
		B_t_real = -1024;
		B_t_imag = 0;
		W_real = 32'h7FFF;
		W_imag = 0;
		#100; 
		A_t_real = -1024;
		A_t_imag = 0;
		B_t_real = 1023;
		B_t_imag = 0;
		W_real = 32'h7FFF;
		W_imag = 0;
		#100; 
		A_t_real = -1024;
		A_t_imag = 0;
		B_t_real = -1024;
		B_t_imag = 0;
		W_real = 32'h7FFF;
		W_imag = 0;
		#100; 
	
	end
							 
endmodule 
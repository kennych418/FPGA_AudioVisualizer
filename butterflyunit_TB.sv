module butterflyunit_TB;
	
	//11 bit 2's complement signed real and imag numbers
	//32 point FFT (2^5) requires 5 extra bits for bit growth
		
	reg [15:0] A_t_real, A_t_imag, B_t_real, B_t_imag, W_real, W_imag;
	wire [15:0] A_f_real, A_f_imag, B_f_real, B_f_imag;
	
	butterflyunit UUT( {A_t_real, A_t_imag}, {B_t_real, B_t_imag}, {W_real, W_imag}, {A_f_real, A_f_imag}, {B_f_real, B_f_imag});
	
	initial begin
	
		A_t_real = 100;
		A_t_imag = 0;
		B_t_real = 100;
		B_t_imag = 0;
		W_real = 16'b0111_1111_1111_1111;	//0 degrees
		W_imag = 16'b0000_0000_0000_0000;	//PASS
		#100; 
		A_t_real = 100;
		A_t_imag = 0;
		B_t_real = 100;
		B_t_imag = 0;
		W_real = 16'b0111_0110_0100_0001;	//-22.5 degrees
		W_imag = 16'b1100_1111_0000_0101;	//PASS
		#100; 
		A_t_real = 100;
		A_t_imag = 0;
		B_t_real = 100;
		B_t_imag = 0;
		W_real = 16'b0101_1010_1000_0010;	//-45.0 degrees
		W_imag = 16'b1010_0101_0111_1110;	//PASS
		#100; 
		A_t_real = 100;
		A_t_imag = 0;
		B_t_real = 100;
		B_t_imag = 0;
		W_real = 16'b0011_0000_1111_1011;	//-67.5 degrees
		W_imag = 16'b1000_1001_1011_1111;	//PASS
		#100;
		A_t_real = 100;
		A_t_imag = 0;
		B_t_real = 100;
		B_t_imag = 0;
		W_real = 16'b0000_0000_0000_0000;	//-90.0 degrees
		W_imag = 16'b1000_0000_0000_0000;	//PASS
		#100; 
		A_t_real = 100;
		A_t_imag = 0;
		B_t_real = 100;
		B_t_imag = 0;
		W_real = 16'b1100_1111_0000_0101;	//-112.5 degrees
		W_imag = 16'b1000_1001_1011_1111;	//PASS
		#100; 
		A_t_real = 100;
		A_t_imag = 0;
		B_t_real = 100;
		B_t_imag = 0;
		W_real = 16'b1010_0101_0111_1110;	//-135.0 degrees
		W_imag = 16'b1010_0101_0111_1110;	//PASS
		#100; 
		A_t_real = 100;
		A_t_imag = 0;
		B_t_real = 100;
		B_t_imag = 0;
		W_real = 16'b1000_1001_1011_1111;	//-157.5 degrees
		W_imag = 16'b1100_1111_0000_0101;	//PASS
		#100; 
		A_t_real = 100;
		A_t_imag = 0;
		B_t_real = 100;
		B_t_imag = 0;
		W_real = 16'b1000_0000_0000_0000;	//-180.0 degrees
		W_imag = 16'b0000_0000_0000_0000;	//PASS
		#100; 
		
	
	end
							 
endmodule 
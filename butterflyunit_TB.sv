`define tmax 1023
`define tmin -1024

`define twiddle0 32'h7fff_0000 //0 deg
`define twiddle1 32'h7641_cf05 //-22.5 deg
`define twiddle2 32'h5a82_a57e //-45 deg
`define twiddle3 32'h30fb_89bf //-67.5 deg
`define twiddle4 32'h0000_8000 //-90 deg
`define twiddle5 32'hcf05_89bf //-112.5 deg
`define twiddle6 32'ha57e_a57e //-135 deg
`define twiddle7 32'h89bf_cf05 //-157.5 deg

module butterflyunit_TB;
	
	//11 bit 2's complement signed real and imag numbers
	//32 point FFT (2^5) requires 5 extra bits for bit growth
		
	reg [15:0] A_t_real, A_t_imag, B_t_real, B_t_imag, W_real, W_imag;
	wire [15:0] A_f_real, A_f_imag, B_f_real, B_f_imag;
	
	butterflyunit UUT( {A_t_real, A_t_imag}, {B_t_real, B_t_imag}, {W_real, W_imag}, {A_f_real, A_f_imag}, {B_f_real, B_f_imag});
	
	initial begin
	
		A_t_real = 16383;
		A_t_imag = 16383;
		B_t_real = 16383;
		B_t_imag = 16383;
		W_real = 16'b0111_1111_1111_1111;	//0 degrees
		W_imag = 16'b0000_0000_0000_0000;	//PASS
		#50;  
		W_real = 16'b0101_1010_1000_0010;	//-45.0 degrees
		W_imag = 16'b1010_0101_0111_1110;	//PASS
		#50; 
		W_real = 16'b0000_0000_0000_0000;	//-90.0 degrees
		W_imag = 16'b1000_0000_0000_0000;	//PASS
		#50; 
		W_real = 16'b1010_0101_0111_1110;	//-135.0 degrees
		W_imag = 16'b1010_0101_0111_1110;	//PASS
		#50; 
		W_real = 16'b1000_0000_0000_0000;	//-180.0 degrees
		W_imag = 16'b0000_0000_0000_0000;	//PASS
		#50; 
		W_real = 16'b1010_0101_0111_1110;	//-225.0 degrees
		W_imag = 16'b0101_1010_1000_0010;	//PASS
		#50;  
		W_real = 16'b0000_0000_0000_0000;	//-270.0 degrees
		W_imag = 16'b0111_1111_1111_1111;	//PASS
		#50; 
		W_real = 16'b0101_1010_1000_0010;	//-315.0 degrees
		W_imag = 16'b0101_1010_1000_0010;	//PASS
		#100; 
		
		A_t_real = 16383;
		A_t_imag = 16383;
		B_t_real = -16384;
		B_t_imag = -16384;
		W_real = 16'b0111_1111_1111_1111;	//0 degrees
		W_imag = 16'b0000_0000_0000_0000;	//PASS
		#50;  
		W_real = 16'b0101_1010_1000_0010;	//-45.0 degrees
		W_imag = 16'b1010_0101_0111_1110;	//PASS
		#50; 
		W_real = 16'b0000_0000_0000_0000;	//-90.0 degrees
		W_imag = 16'b1000_0000_0000_0000;	//PASS
		#50; 
		W_real = 16'b1010_0101_0111_1110;	//-135.0 degrees
		W_imag = 16'b1010_0101_0111_1110;	//PASS
		#50; 
		W_real = 16'b1000_0000_0000_0000;	//-180.0 degrees
		W_imag = 16'b0000_0000_0000_0000;	//PASS
		#50; 
		W_real = 16'b1010_0101_0111_1110;	//-225.0 degrees
		W_imag = 16'b0101_1010_1000_0010;	//PASS
		#50;  
		W_real = 16'b0000_0000_0000_0000;	//-270.0 degrees
		W_imag = 16'b0111_1111_1111_1111;	//PASS
		#50; 
		W_real = 16'b0101_1010_1000_0010;	//-315.0 degrees
		W_imag = 16'b0101_1010_1000_0010;	//PASS
		#100; 
		
		A_t_real = 16383;
		A_t_imag = -16384;
		B_t_real = -16384;
		B_t_imag = 16383;
		W_real = 16'b0111_1111_1111_1111;	//0 degrees
		W_imag = 16'b0000_0000_0000_0000;	//PASS
		#50;  
		W_real = 16'b0101_1010_1000_0010;	//-45.0 degrees
		W_imag = 16'b1010_0101_0111_1110;	//PASS
		#50; 
		W_real = 16'b0000_0000_0000_0000;	//-90.0 degrees
		W_imag = 16'b1000_0000_0000_0000;	//PASS
		#50; 
		W_real = 16'b1010_0101_0111_1110;	//-135.0 degrees
		W_imag = 16'b1010_0101_0111_1110;	//PASS
		#50; 
		W_real = 16'b1000_0000_0000_0000;	//-180.0 degrees
		W_imag = 16'b0000_0000_0000_0000;	//PASS
		#50; 
		W_real = 16'b1010_0101_0111_1110;	//-225.0 degrees
		W_imag = 16'b0101_1010_1000_0010;	//PASS
		#50;  
		W_real = 16'b0000_0000_0000_0000;	//-270.0 degrees
		W_imag = 16'b0111_1111_1111_1111;	//PASS
		#50; 
		W_real = 16'b0101_1010_1000_0010;	//-315.0 degrees
		W_imag = 16'b0101_1010_1000_0010;	//PASS
		#100; 
		
		A_t_real = -16384;
		A_t_imag = -16384;
		B_t_real = -16384;
		B_t_imag = -16384;
		W_real = 16'b0111_1111_1111_1111;	//0 degrees
		W_imag = 16'b0000_0000_0000_0000;	//PASS
		#50;  
		W_real = 16'b0101_1010_1000_0010;	//-45.0 degrees
		W_imag = 16'b1010_0101_0111_1110;	//PASS
		#50; 
		W_real = 16'b0000_0000_0000_0000;	//-90.0 degrees
		W_imag = 16'b1000_0000_0000_0000;	//PASS
		#50; 
		W_real = 16'b1010_0101_0111_1110;	//-135.0 degrees
		W_imag = 16'b1010_0101_0111_1110;	//PASS
		#50; 
		W_real = 16'b1000_0000_0000_0000;	//-180.0 degrees
		W_imag = 16'b0000_0000_0000_0000;	//PASS
		#50; 
		W_real = 16'b1010_0101_0111_1110;	//-225.0 degrees
		W_imag = 16'b0101_1010_1000_0010;	//PASS
		#50;  
		W_real = 16'b0000_0000_0000_0000;	//-270.0 degrees
		W_imag = 16'b0111_1111_1111_1111;	//PASS
		#50; 
		W_real = 16'b0101_1010_1000_0010;	//-315.0 degrees
		W_imag = 16'b0101_1010_1000_0010;	//PASS
		#100; 
		
	
	end
							 
endmodule 
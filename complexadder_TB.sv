module complexadder_TB;
			
	reg [15:0] a_real, b_real, a_imag, b_imag;
	wire [15:0] c_real, c_imag;
	
	complexadder testunit( {a_real, a_imag}, {b_real, b_imag}, {c_real, c_imag});
	
	initial begin
		a_real = 1023;
		a_imag = 1023;
		b_real = 1023;
		b_imag = 1023;
		#100;
		a_real = 1023;
		a_imag = -1024;
		b_real = 1023;
		b_imag = -1024;
		#100;
		a_real = 1023;
		a_imag = 1023;
		b_real = -1024;
		b_imag = -1024;
		#100;
		a_real = -1024;
		a_imag = -1024;
		b_real = 1023;
		b_imag = 1023;
		#100;
		a_real = 1023;
		a_imag = 0;
		b_real = 1023;
		b_imag = 0;
		#100;
		a_real = 0;
		a_imag = 1023;
		b_real = 0;
		b_imag = 1023;
		#100;
		a_real = -1024;
		a_imag = 0;
		b_real = -1024;
		b_imag = 0;
		#100;
		a_real = 0;
		a_imag = -1024;
		b_real = 0;
		b_imag = -1024;
		#100;
		a_real = 1023;
		a_imag = 0;
		b_real = -1024;
		b_imag = 0;
		#100;
		
	end
			
endmodule 
module complexsubtractor_TB;
			
	reg [15:0] a_real, b_real, a_imag, b_imag;
	wire [15:0] c_real, c_imag;
	
	complexsubtractor testunit( {a_real, a_imag}, {b_real, b_imag}, {c_real, c_imag});
	
	initial begin
		a_real = 16383;
		a_imag = 16383;
		b_real = 16383;
		b_imag = 16383;
		#100;
		a_real = 16383;
		a_imag = -16384;
		b_real = 16383;
		b_imag = -16384;
		#100;
		a_real = 16383;
		a_imag = 16383;
		b_real = -16384;
		b_imag = -16384;
		#100;
		a_real = -16384;
		a_imag = -16384;
		b_real = 16383;
		b_imag = 16383;
		#100;
		a_real = 16383;
		a_imag = 0;
		b_real = 16383;
		b_imag = 0;
		#100;
		a_real = 0;
		a_imag = 16383;
		b_real = 0;
		b_imag = 16383;
		#100;
		a_real = -16384;
		a_imag = 0;
		b_real = -16384;
		b_imag = 0;
		#100;
		a_real = 0;
		a_imag = -16384;
		b_real = 0;
		b_imag = -16384;
		#100;
		
	end
			
endmodule 
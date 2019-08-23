module multiplier_TB;
	
	reg [15:0] a_real, a_imag, b_real, b_imag;
	reg [31:0] c_real, c_imag;
	
	complexmultiplier UUT({a_real,a_imag}, {b_real, b_imag}, {c_real, c_imag});
	
	initial begin
	
		a_real = 32767;
		a_imag = 32767;
		b_real = 32767;
		b_imag = 32767;
		#10;
		a_real = -32768;
		a_imag = 32767;
		b_real = -32768;
		b_imag = 32767;
		#10;
		a_real = -32768;
		a_imag = -32768;
		b_real = -32768;
		b_imag = -32768;
		#10;
		a_real = 32767;
		a_imag = -32768;
		b_real = 32767;
		b_imag = -32768;
		#10;
		a_real = 0;
		a_imag = 0;
		b_real = 0;
		b_imag = 0;
		#10;
		a_real = 32767;
		a_imag = 0;
		b_real = 32767;
		b_imag = 0;
		#10;
		a_real = 0;
		a_imag = 32767;
		b_real = 0;
		b_imag = 32767;
		#10;
		a_real = -32768;
		a_imag = 0;
		b_real = -32768;
		b_imag = 0;
		#10;
		a_real = 0;
		a_imag = -32768;
		b_real = 0;
		b_imag = -32768;
		#10;
	
	end
	
endmodule 
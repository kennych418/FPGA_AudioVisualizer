`define tmax_FFT 511
`define tmin_FFT -512

module FFT_Processor_TB;

	integer i;

	reg clk, new_t, reset; 
	wire done;
	reg [15:0] t0, t1, t2, t3, t4, t5, t6, t7, 
				  t8, t9, t10, t11, t12, t13, t14, t15;
	wire [15:0] f0, f1, f2, f3, f4, f5, f6, f7, 
				   f8, f9, f10, f11, f12, f13, f14, f15;
	
	FFT_Processor UUT(clk, reset, new_t,
							t0, t1, t2, t3, t4, t5, t6, t7, 
							t8, t9, t10, t11, t12, t13, t14, t15,
							f0, f1, f2, f3, f4, f5, f6, f7, 
							f8, f9, f10, f11, f12, f13, f14, f15,
							done );
	
	initial begin
	
		clk = 0;
		new_t = 0;
		t0 = `tmax_FFT; t1 = `tmax_FFT; t2 = `tmax_FFT; t3 = `tmax_FFT;
		t4 = 0; t5 = 0; t6 = 0; t7 = 0;
		t8 = `tmin_FFT; t9 = `tmin_FFT; t10 = `tmin_FFT; t11 = `tmin_FFT;
		t12 = 0; t13 = 0; t14 = 0; t15 = 0;
		#100;
		new_t = 1;
		#10;
		clk = 1;
		#10;
		//new_t = 0;
		
		for (i=0; i < 10; i = i + 1) begin
			clk = 0;
			#10;
			clk = 1;
			#10;
		end
		clk = 0;
		//new_t = 1;
		#10;
		clk = 1;
		#10;
		//new_t = 0;
		for (i=0; i < 10; i = i + 1) begin
			clk = 0;
			#10;
			clk = 1;
			#10;
		end
		#100;
		t0 = `tmin_FFT; t1 = `tmax_FFT; t2 = `tmin_FFT; t3 = `tmax_FFT;
		t4 = `tmin_FFT; t5 = `tmax_FFT; t6 = `tmax_FFT; t7 = `tmin_FFT;
		t8 = `tmax_FFT; t9 = `tmin_FFT; t10 = `tmin_FFT; t11 = `tmax_FFT;
		t12 = `tmax_FFT; t13 = `tmin_FFT; t14 = `tmin_FFT; t15 = `tmax_FFT;
		#100;
		new_t = 1;
		clk = 1;
		#10;
		new_t = 0;
		clk = 0;
		#10;
		clk = 1;
		#10;
		clk = 0;
		#10;
		clk = 1;
		#10;
		clk = 0;
		#10;
		clk = 1;
		#10;
		clk = 0;
		#10;
		clk = 1;
		#10;
		clk = 0;
		#10;
		clk = 1;
		#10;
		clk = 0;
		#10;
		clk = 1;
		#10;
		clk = 0;
		#10;
		t0 = 53; t1 = 21; t2 = 34; t3 = 789;
		t4 = 54; t5 = 67; t6 = 890; t7 = 124;
		t8 = 567; t9 = 43; t10 = 56; t11 = 123;
		t12 = 45; t13 = 65; t14 = 43; t15 = 56;
		new_t = 1;
		#1;
		clk = 1;
		#10;
		new_t = 0;
		clk = 0;
		#10;
		clk = 1;
		#10;
		clk = 0;
		#10;
		clk = 1;
		#10;
		clk = 0;
		#10;
		clk = 1;
		#10;
		clk = 0;
		#10;
		clk = 1;
		#10;
		clk = 0;
		#10;
		clk = 1;
		#10;
		clk = 0;
		#10;
		
	
	end

endmodule
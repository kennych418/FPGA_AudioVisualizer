`define tmax 511
`define tmin -512

module FFT_Processor_TB;

	reg clk, new_t; 
	wire done;
	reg [15:0] t0, t1, t2, t3, t4, t5, t6, t7, 
				  t8, t9, t10, t11, t12, t13, t14, t15;
	wire [15:0] f0, f1, f2, f3, f4, f5, f6, f7, 
				   f8, f9, f10, f11, f12, f13, f14, f15;
	
	FFT_Processor UUT(clk, new_t,
							t0, t1, t2, t3, t4, t5, t6, t7, 
							t8, t9, t10, t11, t12, t13, t14, t15,
							f0, f1, f2, f3, f4, f5, f6, f7, 
							f8, f9, f10, f11, f12, f13, f14, f15,
							done );
	
	initial begin
	
		clk = 0;
		new_t = 0;
		t0 = `tmax; t1 = `tmax; t2 = `tmax; t3 = `tmax;
		t4 = 0; t5 = 0; t6 = 0; t7 = 0;
		t8 = `tmin; t9 = `tmin; t10 = `tmin; t11 = `tmin;
		t12 = 0; t13 = 0; t14 = 0; t15 = 0;
		#100;
		new_t = 1;
		#10;
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
		#100;
		t0 = `tmin; t1 = `tmax; t2 = `tmin; t3 = `tmax;
		t4 = `tmin; t5 = `tmax; t6 = `tmax; t7 = `tmin;
		t8 = `tmax; t9 = `tmin; t10 = `tmin; t11 = `tmax;
		t12 = `tmax; t13 = `tmin; t14 = `tmin; t15 = `tmax;
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
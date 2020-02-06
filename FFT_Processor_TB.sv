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
		t0 = 10; t1 = 0; t2 = 10; t3 = 0;
		t4 = 10; t5 = 0; t6 = 10; t7 = 0;
		t8 = 10; t9 = 0; t10 = 10; t11 = 0;
		t12 = 10; t13 = 0; t14 = 10; t15 = 0;
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
		t0 = 10; t1 = 5; t2 = 10; t3 = 3;
		t4 = 10; t5 = 5; t6 = 10; t7 = 3;
		t8 = 10; t9 = 5; t10 = 10; t11 = 3;
		t12 = 10; t13 = 5; t14 = 10; t15 = 3;
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
		t0 = 500; t1 = 500; t2 = 500; t3 = 500;
		t4 = 500; t5 = 0; t6 = 0; t7 = 0;
		t8 = 500; t9 = 500; t10 = 500; t11 = 500;
		t12 = 0; t13 = 0; t14 = 0; t15 = 0;
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
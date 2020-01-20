module FFT(input clk,		  
			  output vsync, output hsync, output [3:0] r, output [3:0] g, output [3:0] b);
	
	wire [15:0] t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15;	//16 bit amplitudes
	reg [31:0] f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15;
	
	//video_sync_generator vga(clk, vsync, hsync, r, g, b);
	
	FFT_Processor main_professor(t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15,
										  f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15);
	
	
endmodule
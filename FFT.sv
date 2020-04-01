module FFT(input clk, input reset, input DOUT, output LRCLK, output BCLK, 		  
			  output vsync, output hsync, output [3:0] r, output [3:0] g, output [3:0] b);
	
	wire new_t, done, system_clk, vga_clk;
	wire [17:0] t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15;	//16 bit amplitudes
	wire [23:0] f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15;
	
	clkdiv #(0) vga_clock(		.clk_in	(clk),
										.clk_out	(vga_clk)	);
										
	clkdiv #(199) main_clock(	.clk_in	(clk),
										.clk_out	(system_clk)	);
								
	
	mic_translator main_translator(	.clk		(system_clk),
												.reset	(reset),
												.DOUT		(DOUT),
												.LRCLK 	(LRCLK),
												.BCLK		(BCLK),
												.new_t	(new_t),
												.t0		(t0),		.t1		(t1),		.t2		(t2),		.t3		(t3),
												.t4		(t4),		.t5		(t5),		.t6		(t6),		.t7		(t7),
												.t8		(t8),		.t9		(t9),		.t10		(t10),	.t11		(t11),
												.t12		(t12),	.t13		(t13),	.t14		(t14),	.t15		(t15)	);
	
	FFT_Processor main_professor(		.clk		(system_clk),
												.reset	(reset),
												.new_t	(new_t),
												.t0		(t0),		.t1		(t1),		.t2		(t2),		.t3		(t3),
												.t4		(t4),		.t5		(t5),		.t6		(t6),		.t7		(t7),
												.t8		(t8),		.t9		(t9),		.t10		(t10),	.t11		(t11),
												.t12		(t12),	.t13		(t13),	.t14		(t14),	.t15		(t15),
												.f0		(f0),		.f1		(f1),		.f2		(f2),		.f3		(f3),
												.f4		(f4),		.f5		(f5),		.f6		(f6),		.f7		(f7),
												.f8		(f8),		.f9		(f9),		.f10		(f10),	.f11		(f11),
												.f12		(f12),	.f13		(f13),	.f14		(f14),	.f15		(f15),	
												.done		(done)	);
	
	video_sync_generator vga(	.clk	(vga_clk),
										.done		(done),
										.vsync	(vsync), 
										.hsync	(hsync), 
										.r			(r), 
										.g			(g), 
										.b			(b),
										.f0		(f0),		.f1		(f1),		.f2		(f2),		.f3		(f3),
										.f4		(f4),		.f5		(f5),		.f6		(f6),		.f7		(f7),
										.f8		(f8),		.f9		(f9),		.f10		(f10),	.f11		(f11),
										.f12		(f12),	.f13		(f13),	.f14		(f14),	.f15		(f15)	);
	
endmodule
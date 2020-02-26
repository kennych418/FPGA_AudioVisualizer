module FFT(input clk, input DOUT, input LRCLK, output BCLK, 		  
			  output vsync, output hsync, output [3:0] r, output [3:0] g, output [3:0] b);
	
	wire new_t, done;
	wire [15:0] t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15;	//16 bit amplitudes
	wire [15:0] f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15;
	
	
	mic_translator main_translator(	.DOUT		(DOUT),
												.LRCLK 	(LRCLK),
												.BCLK		(BCLK),
												.new_t	(new_t),
												.t0		(t0),		.t1		(t1),		.t2		(t2),		.t3		(t3),
												.t4		(t4),		.t5		(t5),		.t6		(t6),		.t7		(t7),
												.t8		(t8),		.t9		(t9),		.t10		(t10),	.t11		(t11),
												.t12		(t12),	.t13		(t13),	.t14		(t14),	.t15		(t15)	);
	
	FFT_Processor main_professor(		.clk		(clk),
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
	
	video_sync_generator vga(	.clk50(clk), 
										.vsync(vsync), 
										.hsync(hsync), 
										.r(r), 
										.g(g), 
										.b(b),
										.f0		(f0),		.f1		(f1),		.f2		(f2),		.f3		(f3),
										.f4		(f4),		.f5		(f5),		.f6		(f6),		.f7		(f7),
										.f8		(f8),		.f9		(f9),		.f10		(f10),	.f11		(f11),
										.f12		(f12),	.f13		(f13),	.f14		(f14),	.f15		(f15)	);
	
endmodule
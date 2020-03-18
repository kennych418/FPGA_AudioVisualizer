module VGA_Components_TB;

	reg clk50,  done,  vsync,  hsync;  
	reg [3:0] r, g, b;
	reg  [15:0] f0,   f1,   f2,   f3,
					f4,   f5,   f6,   f7,
					f8,   f9,   f10,   f11,
					f12,   f13,   f14,   f15;
	
	integer i;
	
	video_sync_generator UUT(	.clk50(clk50),
										.done(done),
										.vsync(vsync),
										.hsync(hsync),
										.r(r),
										.g(g),
										.b(b),
										.f0(f0), .f1(f1), .f2(f2), .f3(f3),
										.f4(f4), .f5(f5), .f6(f6), .f7(f7),
										.f8(f8), .f9(f9), .f10(f10), .f11(f11),
										.f12(f12), .f13(f13), .f14(f14), .f15(f15)	);
										
	initial begin
		
		clk50 = 0;
		done = 1;
		f0 = 16'd240;
		f1 = 16'd16383;
		f2 = 16'd15383;
		f3 = 16'd14000;
		f4 = 16'd17383;
		f5 = 16'd18383;
		f6 = 16'd32767;
		f7 = 16'd480;
		f8 = 16'd1000;
		f9 = 16'd30000;
		f10 = -16'd480;
		f11 = -16'd16;
		f12 = -16'd30000;
		f13 = 16'd0;
		f14 = 16'd0;
		f15 = 16'd0;
		
		for(i = 0; i < 6000; i = i + 1) begin
			#10;
			clk50 = 1;
			#10;
			clk50 = 0;
		end
		
		
	end
	
endmodule
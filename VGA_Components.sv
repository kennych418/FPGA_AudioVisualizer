//=========== VGA Components for 640x480p ===========//

module PLL(clk50, pixelclk);	//setting DE10-Lite 50Mhz clk to 25Mhz pixel clk
	
	input clk50;
	output pixelclk;
	
	reg pixelclk;
	
	initial begin
		pixelclk = 0;
	end
	
	always @ (posedge clk50) begin
		pixelclk = (pixelclk) ? 1'b0 : 1'b1;	//Cuts frequency in half
	end
	
endmodule

module hsync(pixelclk, hsync_out, blank_out, newline_out, pixel_count);

	parameter TOTAL_COUNTER = 800;
	parameter SYNC = 96;
	parameter BACKPORCH = 48;
	parameter DISPLAY = 640;
	parameter FRONTPORCH = 16;

	input pixelclk;
	output hsync_out, blank_out, newline_out;
	output [9:0] pixel_count;
	
	
	reg hsync_out, blank_out, newline_out;
	reg [9:0] counter = 10'b0000000000;
	
	assign pixel_count = counter;
	
	always @ (posedge pixelclk) begin	//counter
		
		if(counter < TOTAL_COUNTER)						//reset counter if every 800 clk cycles
			counter <= counter + 10'b0000000001;
		else
			counter <= 10'b0000000000;
			
	end
	
	always @ (posedge pixelclk) begin	//hsync
	
		if(counter < (DISPLAY + FRONTPORCH))
			hsync_out <= 1;
		else if(counter >= (DISPLAY + FRONTPORCH) && counter < (DISPLAY + FRONTPORCH + SYNC))
			hsync_out <= 0;
		else if(counter >= (DISPLAY + FRONTPORCH + SYNC))	
			hsync_out <= 1;	
			
	end
	
	always @ (posedge pixelclk) begin	//blank
													//high during display interval
		if(counter < DISPLAY)
			blank_out <= 0;
		else
			blank_out <= 1;
		
	end
	
	always @ (posedge pixelclk) begin	//newline
	
		if(counter == 0)
			newline_out <= 1;
		else
			newline_out <= 0;
	
	end

endmodule

module vsync(newline_in, vsync_out, blank_out, pixel_count);

	parameter TOTAL_COUNTER = 525;
	parameter SYNC = 2;
	parameter BACKPORCH = 33;
	parameter DISPLAY = 480;
	parameter FRONTPORCH = 10;

	input newline_in;
	output vsync_out, blank_out;
	output [9:0] pixel_count;
	
	reg vsync_out, blank_out;
	reg [9:0] counter = 10'b0000000000;
	
	assign pixel_count = counter;
	
	always @ (posedge newline_in) begin	//counter
		if(counter < TOTAL_COUNTER)
			counter <= counter + 10'b0000000001;
		else
			counter <= 10'b0000000000;
	end
	
	always @ (posedge newline_in) begin	//vsync
		if(counter < (DISPLAY + FRONTPORCH))
			vsync_out <= 1;
		else if(counter >= (DISPLAY + FRONTPORCH) && counter < (DISPLAY + FRONTPORCH + SYNC))
			vsync_out <= 0;
		else if(counter >= (DISPLAY + FRONTPORCH + SYNC))
			vsync_out <= 1;
	end
	
	always @ (posedge newline_in) begin	//blank
		if(counter < DISPLAY)
			blank_out <= 0;
		else
			blank_out <= 1;
	end

endmodule


module data(input clk, input done, input hblank, input vblank, input [9:0] horizontal_count, input [9:0] vertical_count, 
				output [3:0] r, output [3:0] g, output [3:0] b,
				input [15:0] f0, input [15:0] f1, input [15:0] f2, input [15:0] f3,
				input [15:0] f4, input [15:0] f5, input [15:0] f6, input [15:0] f7,
				input [15:0] f8, input [15:0] f9, input [15:0] f10, input [15:0] f11,
				input [15:0] f12, input [15:0] f13, input [15:0] f14, input [15:0] f15);
	
	reg [3:0] r_reg, g_reg, b_reg;
	
	wire [31:0] scaled_f0, scaled_f1, scaled_f2, scaled_f3, 
				   scaled_f4, scaled_f5, scaled_f6, scaled_f7, 
				   scaled_f8, scaled_f9, scaled_f10, scaled_f11, 
				   scaled_f12, scaled_f13, scaled_f14, scaled_f15;
	
	assign scaled_f0 = ({{16{f0[15]}},f0} * (32'b1111_1111_1111_1111_1111_1110_0010_0000) + 32'b00000_0001_1110_0000_0000_0000_0000_000) >>> 15;	//binary number is -480 //16 bits decimal, 16 bits integer
	assign scaled_f1 = ({{16{f1[15]}},f1} * (32'b1111_1111_1111_1111_1111_1110_0010_0000) + 32'b00000_0001_1110_0000_0000_0000_0000_000) >>> 15;
	assign scaled_f2 = ({{16{f2[15]}},f2} * (32'b1111_1111_1111_1111_1111_1110_0010_0000) + 32'b00000_0001_1110_0000_0000_0000_0000_000) >>> 15;
	assign scaled_f3 = ({{16{f3[15]}},f3} * (32'b1111_1111_1111_1111_1111_1110_0010_0000) + 32'b00000_0001_1110_0000_0000_0000_0000_000) >>> 15;
	assign scaled_f4 = ({{16{f4[15]}},f4} * (32'b1111_1111_1111_1111_1111_1110_0010_0000) + 32'b00000_0001_1110_0000_0000_0000_0000_000) >>> 15;
	assign scaled_f5 = ({{16{f5[15]}},f5} * (32'b1111_1111_1111_1111_1111_1110_0010_0000) + 32'b00000_0001_1110_0000_0000_0000_0000_000) >>> 15;
	assign scaled_f6 = ({{16{f6[15]}},f6} * (32'b1111_1111_1111_1111_1111_1110_0010_0000) + 32'b00000_0001_1110_0000_0000_0000_0000_000) >>> 15;
	assign scaled_f7 = ({{16{f7[15]}},f7} * (32'b1111_1111_1111_1111_1111_1110_0010_0000) + 32'b00000_0001_1110_0000_0000_0000_0000_000) >>> 15;
	assign scaled_f8 = ({{16{f8[15]}},f8} * (32'b1111_1111_1111_1111_1111_1110_0010_0000) + 32'b00000_0001_1110_0000_0000_0000_0000_000) >>> 15;
	assign scaled_f9 = ({{16{f9[15]}},f9} * (32'b1111_1111_1111_1111_1111_1110_0010_0000) + 32'b00000_0001_1110_0000_0000_0000_0000_000) >>> 15;
	assign scaled_f10 = ({{16{f10[15]}},f10} * (32'b1111_1111_1111_1111_1111_1110_0010_0000) + 32'b00000_0001_1110_0000_0000_0000_0000_000) >>> 15;
	assign scaled_f11 = ({{16{f11[15]}},f11} * (32'b1111_1111_1111_1111_1111_1110_0010_0000) + 32'b00000_0001_1110_0000_0000_0000_0000_000) >>> 15;
	assign scaled_f12 = ({{16{f12[15]}},f12} * (32'b1111_1111_1111_1111_1111_1110_0010_0000) + 32'b00000_0001_1110_0000_0000_0000_0000_000) >>> 15;
	assign scaled_f13 = ({{16{f13[15]}},f13} * (32'b1111_1111_1111_1111_1111_1110_0010_0000) + 32'b00000_0001_1110_0000_0000_0000_0000_000) >>> 15;
	assign scaled_f14 = ({{16{f14[15]}},f14} * (32'b1111_1111_1111_1111_1111_1110_0010_0000) + 32'b00000_0001_1110_0000_0000_0000_0000_000) >>> 15;
	assign scaled_f15 = ({{16{f15[15]}},f15} * (32'b1111_1111_1111_1111_1111_1110_0010_0000) + 32'b00000_0001_1110_0000_0000_0000_0000_000) >>> 15;
	
	assign r = r_reg;
	assign g = g_reg;
	assign b = b_reg;
	
	always @ (posedge clk) begin
		if (hblank == 1 || vblank == 1) begin
			r_reg <= 4'b0;
			g_reg <= 4'b0;
			b_reg <= 4'b0;
		end
		/*
		else begin
			r_reg <= {f3[5], f2[5], f0[5], 1'b1};
			g_reg <= {f7[5], f6[5], f5[5], f4[5]};
			b_reg <= {f11[5], f10[5], f9[5], f8[0]};
		end
		*/
		else if (horizontal_count < 40) begin
			r_reg <= (vertical_count > scaled_f0) ? 4'b1100 : 4'b0;
			g_reg <= (vertical_count > scaled_f0) ? 4'b0000 : 4'b0;
			b_reg <= (vertical_count > scaled_f0) ? 4'b0000 : 4'b0;
		end
		else if (horizontal_count > 40 && horizontal_count < 80) begin
			r_reg <= (vertical_count > scaled_f1) ? 4'b1100 : 4'b0;
			g_reg <= (vertical_count > scaled_f1) ? 4'b0000 : 4'b0;
			b_reg <= (vertical_count > scaled_f1) ? 4'b0000 : 4'b0;
		end
		else if (horizontal_count > 80 && horizontal_count < 120) begin
			r_reg <= (vertical_count > scaled_f2) ? 4'b1100 : 4'b0;
			g_reg <= (vertical_count > scaled_f2) ? 4'b0000 : 4'b0;
			b_reg <= (vertical_count > scaled_f2) ? 4'b0000 : 4'b0;
		end
		else if (horizontal_count > 120 && horizontal_count < 160) begin
			r_reg <= (vertical_count > scaled_f3) ? 4'b1100 : 4'b0;
			g_reg <= (vertical_count > scaled_f3) ? 4'b0000 : 4'b0;
			b_reg <= (vertical_count > scaled_f3) ? 4'b0000 : 4'b0;
		end
		else if (horizontal_count > 160 && horizontal_count < 200) begin
			r_reg <= (vertical_count > scaled_f4) ? 4'b1100 : 4'b0;
			g_reg <= (vertical_count > scaled_f4) ? 4'b0000 : 4'b0;
			b_reg <= (vertical_count > scaled_f4) ? 4'b0000 : 4'b0;
		end
		else if (horizontal_count > 200 && horizontal_count < 240) begin
			r_reg <= (vertical_count > scaled_f5) ? 4'b1100 : 4'b0;
			g_reg <= (vertical_count > scaled_f5) ? 4'b0000 : 4'b0;
			b_reg <= (vertical_count > scaled_f5) ? 4'b0000 : 4'b0;
		end
		else if (horizontal_count > 240 && horizontal_count < 280) begin
			r_reg <= (vertical_count > scaled_f6) ? 4'b1100 : 4'b0;
			g_reg <= (vertical_count > scaled_f6) ? 4'b0000 : 4'b0;
			b_reg <= (vertical_count > scaled_f6) ? 4'b0000 : 4'b0;
		end
		else if (horizontal_count > 280 && horizontal_count < 320) begin
			r_reg <= (vertical_count > scaled_f7) ? 4'b1100 : 4'b0;
			g_reg <= (vertical_count > scaled_f7) ? 4'b0000 : 4'b0;
			b_reg <= (vertical_count > scaled_f7) ? 4'b0000 : 4'b0;
		end
		else if (horizontal_count > 320 && horizontal_count < 360) begin
			r_reg <= (vertical_count > scaled_f8) ? 4'b1100 : 4'b0;
			g_reg <= (vertical_count > scaled_f8) ? 4'b0000 : 4'b0;
			b_reg <= (vertical_count > scaled_f8) ? 4'b0000 : 4'b0;
		end
		else if (horizontal_count > 360 && horizontal_count < 400) begin
			r_reg <= (vertical_count > scaled_f9) ? 4'b1100 : 4'b0;
			g_reg <= (vertical_count > scaled_f9) ? 4'b0000 : 4'b0;
			b_reg <= (vertical_count > scaled_f9) ? 4'b0000 : 4'b0;
		end
		else if (horizontal_count > 400 && horizontal_count < 440) begin
			r_reg <= (vertical_count > scaled_f10) ? 4'b1100 : 4'b0;
			g_reg <= (vertical_count > scaled_f10) ? 4'b0000 : 4'b0;
			b_reg <= (vertical_count > scaled_f10) ? 4'b0000 : 4'b0;
		end
		else if (horizontal_count > 440 && horizontal_count < 480) begin
			r_reg <= (vertical_count > scaled_f11) ? 4'b1100 : 4'b0;
			g_reg <= (vertical_count > scaled_f11) ? 4'b0000 : 4'b0;
			b_reg <= (vertical_count > scaled_f11) ? 4'b0000 : 4'b0;
		end
		else if (horizontal_count > 480 && horizontal_count < 520) begin
			r_reg <= (vertical_count > scaled_f12) ? 4'b1100 : 4'b0;
			g_reg <= (vertical_count > scaled_f12) ? 4'b0000 : 4'b0;
			b_reg <= (vertical_count > scaled_f12) ? 4'b0000 : 4'b0;
		end
		else if (horizontal_count > 520 && horizontal_count < 560) begin
			r_reg <= (vertical_count > scaled_f13) ? 4'b1100 : 4'b0;
			g_reg <= (vertical_count > scaled_f13) ? 4'b0000 : 4'b0;
			b_reg <= (vertical_count > scaled_f13) ? 4'b0000 : 4'b0;
		end
		else if (horizontal_count > 560 && horizontal_count < 600) begin
			r_reg <= (vertical_count > scaled_f14) ? 4'b1100 : 4'b0;
			g_reg <= (vertical_count > scaled_f14) ? 4'b0000 : 4'b0;
			b_reg <= (vertical_count > scaled_f14) ? 4'b0000 : 4'b0;
		end
		else if (horizontal_count > 600 && horizontal_count < 640) begin
			r_reg <= (vertical_count > scaled_f15) ? 4'b1100 : 4'b0;
			g_reg <= (vertical_count > scaled_f15) ? 4'b0000 : 4'b0;
			b_reg <= (vertical_count > scaled_f15) ? 4'b0000 : 4'b0;
		end
		else begin
			r_reg <= 4'b1111;
			g_reg <= 4'b1111;
			b_reg <= 4'b1111;
		end
		
	end

endmodule

module video_sync_generator(input clk50, input done, output vsync, output hsync, output [3:0] r, output [3:0] g, output [3:0] b,
									 input [15:0] f0, input [15:0] f1, input [15:0] f2, input [15:0] f3,
									 input [15:0] f4, input [15:0] f5, input [15:0] f6, input [15:0] f7,
									 input [15:0] f8, input [15:0] f9, input [15:0] f10, input [15:0] f11,
									 input [15:0] f12, input [15:0] f13, input [15:0] f14, input [15:0] f15);

	
	wire pixelclk, hblank, vblank, newline, newframe;
	wire [9:0] horizontal_count, vertical_count;
	
	reg [15:0] f0_reg, f1_reg, f2_reg, f3_reg, 
				  f4_reg, f5_reg, f6_reg, f7_reg, 
				  f8_reg, f9_reg, f10_reg, f11_reg, 
				  f12_reg, f13_reg, f14_reg, f15_reg;
	
	PLL clockdivider(clk50, pixelclk);
	
	hsync horizontal(pixelclk, hsync, hblank, newline, horizontal_count);
	vsync vertical(newline, vsync, vblank, vertical_count);
	
	always @ (posedge pixelclk) begin
		if (horizontal_count >  640 && vertical_count > 480 && done) begin
			f0_reg <= f0[15] ? (~f0 + 1): f0;
			f1_reg <= f1[15] ? (~f1 + 1): f1;
			f2_reg <= f2[15] ? (~f2 + 1): f2;
			f3_reg <= f3[15] ? (~f3 + 1): f3;
			f4_reg <= f4[15] ? (~f4 + 1): f4;
			f5_reg <= f5[15] ? (~f5 + 1): f5;
			f6_reg <= f6[15] ? (~f6 + 1): f6;
			f7_reg <= f7[15] ? (~f7 + 1): f7;
			f8_reg <= f8[15] ? (~f8 + 1): f8;
			f9_reg <= f9[15] ? (~f9 + 1): f9;
			f10_reg <= f10[15] ? (~f10 + 1) : f10;
			f11_reg <= f11[15] ? (~f11 + 1) : f11;
			f12_reg <= f12[15] ? (~f12 + 1) : f12;
			f13_reg <= f13[15] ? (~f13 + 1) : f13;
			f14_reg <= f14[15] ? (~f14 + 1) : f14;
			f15_reg <= f15[15] ? (~f15 + 1) : f15;
		end
	end
	
	
	data display(	.clk					(pixelclk),
						.done					(done),
						.hblank				(hblank), 
						.vblank				(vblank), 
						.horizontal_count	(horizontal_count),
						.vertical_count	(vertical_count),
						.r						(r), 
						.g						(g), 
						.b						(b),
						.f0		(f0_reg),		.f1		(f1_reg),		.f2		(f2_reg),		.f3		(f3_reg),
						.f4		(f4_reg),		.f5		(f5_reg),		.f6		(f6_reg),		.f7		(f7_reg),
						.f8		(f8_reg),		.f9		(f9_reg),		.f10		(f10_reg),		.f11		(f11_reg),
						.f12		(f12_reg),		.f13		(f13_reg),		.f14		(f14_reg),		.f15		(f15_reg)	);
	
endmodule
//=========== VGA Components for 640x480p ===========//

module PLL(clk50, pixelclk);	//setting DE10-Lite 50Mhz clk to 25Mhz pixel clk
	
	input clk50;
	output pixelclk;
	
	reg pixelclk;
	
	always @ (posedge clk50) begin
		pixelclk = (pixelclk) ? 1'b0 : 1'b1;	//Cuts frequency in half
	end
	
endmodule

module hsync(pixelclk, hsync_out, blank_out, newline_out);

	parameter TOTAL_COUNTER = 800;
	parameter SYNC = 96;
	parameter BACKPORCH = 48;
	parameter DISPLAY = 640;
	parameter FRONTPORCH = 16;

	input pixelclk;
	output hsync_out, blank_out, newline_out;
	
	
	reg hsync_out, blank_out, newline_out;
	reg [9:0] counter = 10'b0000000000;
	
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

module vsync(newline_in, vsync_out, blank_out);

	parameter TOTAL_COUNTER = 525;
	parameter SYNC = 2;
	parameter BACKPORCH = 33;
	parameter DISPLAY = 480;
	parameter FRONTPORCH = 10;

	input newline_in;
	output vsync_out, blank_out;
	
	reg vsync_out, blank_out;
	reg [9:0] counter = 10'b0000000000;
	
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


module data(input clk, input hblank, input vblank, output [3:0] r, output [3:0] g, output [3:0] b,
				output [15:0] f0, output [15:0] f1, output [15:0] f2, output [15:0] f3,
				output [15:0] f4, output [15:0] f5, output [15:0] f6, output [15:0] f7,
				output [15:0] f8, output [15:0] f9, output [15:0] f10, output [15:0] f11,
				output [15:0] f12, output [15:0] f13, output [15:0] f14, output [15:0] f15);
	
	always @ (posedge clk) begin
		if (hblank == 1 || vblank == 1) begin
			r <= 0;
			g <= 0;
			b <= 0;
		end
		else begin
			r <= 4'b1000;
			g <= 4'b0000;
			b <= 4'b1000;
			//=======Handled Arduino Side=========//
		end
	end

endmodule

module video_sync_generator(input clk50, output vsync, output hsync, output [3:0] r, output [3:0] g, output [3:0] b,
									 output [15:0] f0, output [15:0] f1, output [15:0] f2, output [15:0] f3,
									 output [15:0] f4, output [15:0] f5, output [15:0] f6, output [15:0] f7,
									 output [15:0] f8, output [15:0] f9, output [15:0] f10, output [15:0] f11,
									 output [15:0] f12, output [15:0] f13, output [15:0] f14, output [15:0] f15);

	
	wire pixelclk, hblank, vblank, newline;
	
	PLL clockdivider(clk50, pixelclk);
	
	hsync horizontal(pixelclk, hsync, hblank, newline);
	vsync vertical(newline, vsync, vblank);
	
	data display(	.clk(pixelclk), 
						.hblank(hblank), 
						.vblank(vblank), 
						.r(r), 
						.g(g), 
						.b(b),
						.f0		(f0),		.f1		(f1),		.f2		(f2),		.f3		(f3),
						.f4		(f4),		.f5		(f5),		.f6		(f6),		.f7		(f7),
						.f8		(f8),		.f9		(f9),		.f10		(f10),	.f11		(f11),
						.f12		(f12),	.f13		(f13),	.f14		(f14),	.f15		(f15)	);
	
endmodule
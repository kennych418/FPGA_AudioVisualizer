module FFT(input clk,		  
			  output vsync, output hsync, output [3:0] r, output [3:0] g, output [3:0] b,
			  input t_number);
	
	wire [31:0] MemToBFU_A, MemToBFU_B;	//31:16 real, 15:0 imaginary
	wire [31:0] BFUToMem_A, BFUToMem_B;	//31:16 real, 15:0 imaginary
	
	//video_sync_generator vga(clk, vsync, hsync, r, g, b);
	
	butterflyunit BFU( //inputs
							 .A_t(MemToBFU_A), .B_t(MemToBFU_B), 
							 //outputs
							 .A_f(BFUToMem_A), .B_f(BFUToMem_B));
	
	
endmodule
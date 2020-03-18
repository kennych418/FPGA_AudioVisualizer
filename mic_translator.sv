`define _NUM_DATA_BITS 31

module mic_translator(input clk, input reset, input DOUT, output LRCLK, output BCLK, output new_t,
							 output [15:0] t0, output [15:0] t1, output [15:0] t2, output [15:0] t3, 
							 output [15:0] t4, output [15:0] t5, output [15:0] t6, output [15:0] t7, 
							 output [15:0] t8, output [15:0] t9, output [15:0] t10, output [15:0] t11, 
							 output [15:0] t12, output [15:0] t13, output [15:0] t14, output [15:0] t15);
	
	reg [9:0] data_buffer;
	reg [6:0] data_counter;
	reg [31:0] bit_cnt;
	wire BCLK_out;
	
	//Dumb shit i have to do for the simulator to work
	reg [15:0] t0_reg, t1_reg, t2_reg, t3_reg,
				  t4_reg, t5_reg, t6_reg, t7_reg,
				  t8_reg, t9_reg, t10_reg, t11_reg,
				  t12_reg, t13_reg, t14_reg, t15_reg;
	reg LRCLK_reg, new_t_reg;
	assign t0 = t0_reg;
	assign t1 = t1_reg;
	assign t2 = t2_reg;
	assign t3 = t3_reg;
	assign t4 = t4_reg;
	assign t5 = t5_reg;
	assign t6 = t6_reg;
	assign t7 = t7_reg;
	assign t8 = t8_reg;
	assign t9 = t9_reg;
	assign t10 = t10_reg;
	assign t11 = t11_reg;
	assign t12 = t12_reg;
	assign t13 = t13_reg;
	assign t14 = t14_reg;
	assign t15 = t15_reg;
	assign LRCLK = LRCLK_reg;
	assign new_t = new_t_reg;
	
	//50MHz to 3MHz Clock Divider for generating BCLK
	clkdiv #(30) BCLK_gen(	.clk_in	(clk),
									.clk_out	(BCLK_out)	);
	
	assign BCLK = BCLK_out | (~reset);
	
	always @ (negedge BCLK_out) begin
		if (reset == 1'b0) begin
			LRCLK_reg <= 1;
			bit_cnt <= 0;
		end
		else if (bit_cnt < `_NUM_DATA_BITS) begin
			LRCLK_reg <= LRCLK_reg;
			bit_cnt <= bit_cnt + 1;
		end
		else begin
			LRCLK_reg <= ~LRCLK_reg;
			bit_cnt <= 0;
		end
	end
	
	always @ (posedge BCLK_out) begin
		if (reset == 1'b0) begin
			data_counter <= 0;
			data_buffer <= 0;
			new_t_reg <= 1'b0;
			t15_reg <= 16'b0;
			t14_reg <= 16'b0;
			t13_reg <= 16'b0;
			t12_reg <= 16'b0;
			t11_reg <= 16'b0;
			t10_reg <= 16'b0;
			t9_reg <= 16'b0;
			t8_reg <= 16'b0;
			t7_reg <= 16'b0;
			t6_reg <= 16'b0;
			t5_reg <= 16'b0;
			t4_reg <= 16'b0;
			t3_reg <= 16'b0;
			t2_reg <= 16'b0;
			t1_reg <= 16'b0;
			t0_reg <= 16'b0;
		end
		else if (data_counter < 10) begin
			data_counter <= data_counter + 6'b1;
			data_buffer <= {data_buffer[8:0], DOUT};
			new_t_reg <= 1'b0;
		end
		else if (data_counter == 10) begin
			t15_reg <= t14_reg;
			t14_reg <= t13_reg;
			t13_reg <= t12_reg;
			t12_reg <= t11_reg;
			t11_reg <= t10_reg;
			t10_reg <= t9_reg;
			t9_reg <= t8_reg;
			t8_reg <= t7_reg;
			t7_reg <= t6_reg;
			t6_reg <= t5_reg;
			t5_reg <= t4_reg;
			t4_reg <= t3_reg;
			t3_reg <= t2_reg;
			t2_reg <= t1_reg;
			t1_reg <= t0_reg;
			t0_reg <= {6'b0, data_buffer}; //FFT Processor takes 10 bit 2's complement
			data_counter <= data_counter + 6'b1;
			new_t_reg <= 1'b1;
		end
		else if (data_counter >= `_NUM_DATA_BITS) begin
			data_buffer <= 10'b0;
			data_counter <= 0;
			new_t_reg <= 1'b0;
		end
		else
			data_counter <= data_counter + 6'b1;
	end
	
endmodule
`define twiddle0 32'h7fff_0000 //0 deg
`define twiddle1 32'h7641_cf05 //-22.5 deg
`define twiddle2 32'h5a82_a57e //-45 deg
`define twiddle3 32'h30fb_89bf //-67.5 deg
`define twiddle4 32'h0000_8000 //-90 deg
`define twiddle5 32'hcf05_89bf //-112.5 deg
`define twiddle6 32'ha57e_a57e //-135 deg
`define twiddle7 32'h89bf_cf05 //-157.5 deg

module FFT_Processor(input clk, input reset, input new_t,
							input [17:0] t0, input [17:0] t1, input [17:0] t2, input [17:0] t3, 
							input [17:0] t4, input [17:0] t5, input [17:0] t6, input [17:0] t7,
							input [17:0] t8, input [17:0] t9, input [17:0] t10, input [17:0] t11,
							input [17:0] t12, input [17:0] t13, input [17:0] t14, input [17:0] t15,
							output [15:0] f0, output [15:0] f1, output [15:0] f2, output [15:0] f3,
							output [15:0] f4, output [15:0] f5, output [15:0] f6, output [15:0] f7,
							output [15:0] f8, output [15:0] f9, output [15:0] f10, output [15:0] f11,
							output [15:0] f12, output [15:0] f13, output [15:0] f14, output [15:0] f15,
							output done);

	reg done_reg;
	
	reg [3:0] cycles_counter;
	
	reg [31:0] W0, W1, W2, W3, W4, W5, W6, W7;
	
	reg [31:0] mem0, mem1, mem2, mem3, 
				  mem4, mem5, mem6, mem7, 
				  mem8, mem9, mem10, mem11,
				  mem12, mem13, mem14, mem15;
				  
	wire [31:0] BFU_out0, BFU_out1, BFU_out2, BFU_out3,
					BFU_out4, BFU_out5, BFU_out6, BFU_out7,
					BFU_out8, BFU_out9, BFU_out10, BFU_out11,
					BFU_out12, BFU_out13, BFU_out14, BFU_out15;
	
	initial begin
		cycles_counter = 4;
	end
	
	always @ (posedge clk) begin
		if (reset == 0) begin
			mem0 <= {16'd1000, 16'b0};//32'b0;
			mem1 <= {16'd3000, 16'b0};//32'b0;
			mem2 <= {16'd5000, 16'b0};//32'b0;
			mem3 <= {16'd7000, 16'b0};//32'b0;
			mem4 <= {16'd9000, 16'b0};//32'b0;
			mem5 <= {16'd11000, 16'b0};//32'b0;
			mem6 <= {16'd13000, 16'b0};//32'b0;
			mem7 <= {16'd15000, 16'b0};//32'b0;
			mem8 <= {16'd17000, 16'b0};//32'b0;
			mem9 <= {16'd19000, 16'b0};//32'b0;
			mem10 <= {16'd21000, 16'b0};//32'b0;
			mem11 <= {16'd23000, 16'b0};//32'b0;
			mem12 <= {16'd25000, 16'b0};//32'b0;
			mem13 <= {16'd27000, 16'b0};//32'b0;
			mem14 <= {16'd29000, 16'b0};//32'b0;
			mem15 <= {16'd31000, 16'b0};//32'b0;
			W0 <= 32'b0;
			W1 <= 32'b0;
			W2 <= 32'b0;
			W3 <= 32'b0;
			W4 <= 32'b0;
			W5 <= 32'b0;
			W6 <= 32'b0;
			W7 <= 32'b0;
			cycles_counter <= 4;
			done_reg <= 1;			/////////////////SHOULD REALLY BE 0
		end
		else begin
			if (new_t && cycles_counter == 4) begin
				mem0 <= { {6{t0[14]}}, t0[14:5], 16'b0};
				mem1 <= { {6{t8[14]}}, t8[14:5], 16'b0};
				mem2 <= { {6{t4[14]}}, t4[14:5], 16'b0};
				mem3 <= { {6{t12[14]}}, t12[14:5], 16'b0};
				mem4 <= { {6{t2[14]}}, t2[14:5], 16'b0};
				mem5 <= { {6{t10[14]}}, t10[14:5], 16'b0};
				mem6 <= { {6{t6[14]}}, t6[14:5], 16'b0};
				mem7 <= { {6{t14[14]}}, t14[14:5], 16'b0};
				mem8 <= { {6{t1[14]}}, t1[14:5], 16'b0};
				mem9 <= { {6{t9[14]}}, t9[14:5], 16'b0};
				mem10 <= { {6{t5[14]}}, t5[14:5], 16'b0};
				mem11 <= { {6{t13[14]}}, t13[14:5], 16'b0};
				mem12 <= { {6{t3[14]}}, t3[14:5], 16'b0};
				mem13 <= { {6{t11[14]}}, t11[14:5], 16'b0};
				mem14 <= { {6{t7[14]}}, t7[14:5], 16'b0};
				mem15 <= { {6{t15[14]}}, t15[14:5], 16'b0};
				W0 <= `twiddle0;
				W1 <= `twiddle0;
				W2 <= `twiddle0;
				W3 <= `twiddle0;
				W4 <= `twiddle0;
				W5 <= `twiddle0;
				W6 <= `twiddle0;
				W7 <= `twiddle0;
				cycles_counter <= 0;
				done_reg <= 0;
			end
			else begin
				if(cycles_counter == 0) begin
					mem0 <= BFU_out0;
					mem1 <= BFU_out2;
					mem2 <= BFU_out1;
					mem3 <= BFU_out3;
					mem4 <= BFU_out4;
					mem5 <= BFU_out6;
					mem6 <= BFU_out5;
					mem7 <= BFU_out7;
					mem8 <= BFU_out8;
					mem9 <= BFU_out10;
					mem10 <= BFU_out9;
					mem11 <= BFU_out11;
					mem12 <= BFU_out12;
					mem13 <= BFU_out14;
					mem14 <= BFU_out13;
					mem15 <= BFU_out15;
					W0 <= `twiddle0;
					W1 <= `twiddle4;
					W2 <= `twiddle0;
					W3 <= `twiddle4;
					W4 <= `twiddle0;
					W5 <= `twiddle4;
					W6 <= `twiddle0;
					W7 <= `twiddle4;
				end
				else if(cycles_counter == 1) begin
					mem0 <= BFU_out0;
					mem1 <= BFU_out4;
					mem2 <= BFU_out2;
					mem3 <= BFU_out6;
					mem4 <= BFU_out1;
					mem5 <= BFU_out5;
					mem6 <= BFU_out3;
					mem7 <= BFU_out7;
					mem8 <= BFU_out8;
					mem9 <= BFU_out12;
					mem10 <= BFU_out10;
					mem11 <= BFU_out14;
					mem12 <= BFU_out9;
					mem13 <= BFU_out13;
					mem14 <= BFU_out11;
					mem15 <= BFU_out15;
					W0 <= `twiddle0;
					W1 <= `twiddle2;
					W2 <= `twiddle4;
					W3 <= `twiddle6;
					W4 <= `twiddle0;
					W5 <= `twiddle2;
					W6 <= `twiddle4;
					W7 <= `twiddle6;
				end
				else if(cycles_counter == 2) begin
					mem0 <= BFU_out0;
					mem1 <= BFU_out8;
					mem2 <= BFU_out2;
					mem3 <= BFU_out10;
					mem4 <= BFU_out4;
					mem5 <= BFU_out12;
					mem6 <= BFU_out6;
					mem7 <= BFU_out14;
					mem8 <= BFU_out1;
					mem9 <= BFU_out9;
					mem10 <= BFU_out3;
					mem11 <= BFU_out11;
					mem12 <= BFU_out5;
					mem13 <= BFU_out13;
					mem14 <= BFU_out7;
					mem15 <= BFU_out15;
					W0 <= `twiddle0;
					W1 <= `twiddle1;
					W2 <= `twiddle2;
					W3 <= `twiddle3;
					W4 <= `twiddle4;
					W5 <= `twiddle5;
					W6 <= `twiddle6;
					W7 <= `twiddle7;
				end
				else if(cycles_counter == 3) begin
					mem0 <= BFU_out0;
					mem1 <= BFU_out2;
					mem2 <= BFU_out4;
					mem3 <= BFU_out6;
					mem4 <= BFU_out8;
					mem5 <= BFU_out10;
					mem6 <= BFU_out12;
					mem7 <= BFU_out14;
					mem8 <= BFU_out1;
					mem9 <= BFU_out3;
					mem10 <= BFU_out5;
					mem11 <= BFU_out7;
					mem12 <= BFU_out9;
					mem13 <= BFU_out11;
					mem14 <= BFU_out13;
					mem15 <= BFU_out15;
					W0 <= `twiddle0;
					W1 <= `twiddle0;
					W2 <= `twiddle0;
					W3 <= `twiddle0;
					W4 <= `twiddle0;
					W5 <= `twiddle0;
					W6 <= `twiddle0;
					W7 <= `twiddle0;
					done_reg <= 1;
				end		
				if (cycles_counter < 4) begin
					cycles_counter <= cycles_counter + 3'b1;
				end
			end
		end
	end
	
	assign done = done_reg;
	
	assign f0 = mem0[31:16];
	assign f1 = mem1[31:16];
	assign f2 = mem2[31:16];
	assign f3 = mem3[31:16];
	assign f4 = mem4[31:16];
	assign f5 = mem5[31:16];
	assign f6 = mem6[31:16];
	assign f7 = mem7[31:16];
	assign f8 = mem8[31:16];
	assign f9 = mem9[31:16];
	assign f10 = mem10[31:16];
	assign f11 = mem11[31:16];
	assign f12 = mem12[31:16];
	assign f13 = mem13[31:16];
	assign f14 = mem14[31:16];
	assign f15 = mem15[31:16];
	
	butterflyunit BFU0(				.A_t	(mem0),
											.B_t	(mem1),
											.W		(W0),
											.A_f	(BFU_out0),
											.B_f	(BFU_out1)	);
	
	butterflyunit BFU1(				.A_t	(mem2),
											.B_t	(mem3),
											.W		(W1),
											.A_f	(BFU_out2),
											.B_f	(BFU_out3)	);
	
	butterflyunit BFU2(				.A_t	(mem4),
											.B_t	(mem5),
											.W		(W2),
											.A_f	(BFU_out4),
											.B_f	(BFU_out5)	);
	
	butterflyunit BFU3(				.A_t	(mem6),
											.B_t	(mem7),
											.W		(W3),
											.A_f	(BFU_out6),
											.B_f	(BFU_out7)	);
	
	butterflyunit BFU4(				.A_t	(mem8),
											.B_t	(mem9),
											.W		(W4),
											.A_f	(BFU_out8),
											.B_f	(BFU_out9)	);
	
	butterflyunit BFU5(				.A_t	(mem10),
											.B_t	(mem11),
											.W		(W5),
											.A_f	(BFU_out10),
											.B_f	(BFU_out11)	);
	
	butterflyunit BFU6(				.A_t	(mem12),
											.B_t	(mem13),
											.W		(W6),
											.A_f	(BFU_out12),
											.B_f	(BFU_out13)	);
	
	butterflyunit BFU7(				.A_t	(mem14),
											.B_t	(mem15),
											.W		(W7),
											.A_f	(BFU_out14),
											.B_f	(BFU_out15)	);
	
							
endmodule
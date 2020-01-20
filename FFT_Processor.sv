module FFT_Processor(input [15:0] t0, input [15:0] t1, input [15:0] t2, input [15:0] t3, 
							input [15:0] t4, input [15:0] t5, input [15:0] t6, input [15:0] t7,
							input [15:0] t8, input [15:0] t9, input [15:0] t10, input [15:0] t11,
							input [15:0] t12, input [15:0] t13, input [15:0] t14, input [15:0] t15,
							output [31:0] f0, output [31:0] f1, output [31:0] f2, output [31:0] f3,
							output [31:0] f4, output [31:0] f5, output [31:0] f6, output [31:0] f7,
							output [31:0] f8, output [31:0] f9, output [31:0] f10, output [31:0] f11,
							output [31:0] f12, output [31:0] f13, output [31:0] f14, output [31:0] f15);

	reg [31:0] W0, W1, W2, W3, W4, W5, W6, W7;
	
	assign W0 = {16'b0111_1111_1111_1111, 16'b0000_0000_0000_000};
	assign W1 = {16'b0111_1111_1111_1111, 16'b0000_0000_0000_000};
	assign W2 = {16'b0111_1111_1111_1111, 16'b0000_0000_0000_000};
	assign W3 = {16'b0111_1111_1111_1111, 16'b0000_0000_0000_000};
	assign W4 = {16'b0111_1111_1111_1111, 16'b0000_0000_0000_000};
	assign W5 = {16'b0111_1111_1111_1111, 16'b0000_0000_0000_000};
	assign W6 = {16'b0111_1111_1111_1111, 16'b0000_0000_0000_000};
	assign W7 = {16'b0111_1111_1111_1111, 16'b0000_0000_0000_000};
	
	
	
	butterflyunit BFU0(				.A_t	({t0[15:0], 16'b0}),
											.B_t	({t1[15:0], 16'b0}),
											.W		(W0),
											.A_f	(f0),
											.B_f	(f1)	);
	
	butterflyunit BFU1(				.A_t	({t2[15:0], 16'b0}),
											.B_t	({t3[15:0], 16'b0}),
											.W		(W1),
											.A_f	(f2),
											.B_f	(f3)	);
	
	butterflyunit BFU2(				.A_t	({t4[15:0], 16'b0}),
											.B_t	({t5[15:0], 16'b0}),
											.W		(W2),
											.A_f	(f4),
											.B_f	(f5)	);
	
	butterflyunit BFU3(				.A_t	({t6[15:0], 16'b0}),
											.B_t	({t7[15:0], 16'b0}),
											.W		(W3),
											.A_f	(f6),
											.B_f	(f7)	);
	
	butterflyunit BFU4(				.A_t	({t8[15:0], 16'b0}),
											.B_t	({t9[15:0], 16'b0}),
											.W		(W4),
											.A_f	(f8),
											.B_f	(f9)	);
	
	butterflyunit BFU5(				.A_t	({t10[15:0], 16'b0}),
											.B_t	({t11[15:0], 16'b0}),
											.W		(W5),
											.A_f	(f10),
											.B_f	(f11)	);
	
	butterflyunit BFU6(				.A_t	({t12[15:0], 16'b0}),
											.B_t	({t13[15:0], 16'b0}),
											.W		(W6),
											.A_f	(f12),
											.B_f	(f13)	);
	
	butterflyunit BFU7(				.A_t	({t14[15:0], 16'b0}),
											.B_t	({t15[15:0], 16'b0}),
											.W		(W7),
											.A_f	(f14),
											.B_f	(f15)	);
	
							
endmodule
module clkdiv50to4(input clk50, output clk4);
	
	reg [2:0] clk_counter;
	reg slowclk;
	
	initial begin
		clk_counter = 0;
		slowclk = 0;
	end
	
	assign clk4 = slowclk;
	
	always @ (posedge clk50) begin
		if (clk_counter == 6) begin
			clk_counter <= 0;
			slowclk <= ~slowclk;
		end
		else begin
			clk_counter <= clk_counter + 1;
		end
	end
	
endmodule
create_clock -name clk -period 20.000 [get_ports {clk}]
create_clock -name clk_virt -period 20.000
create_generated_clock -name system_clk -source [get_ports {clk}] -divide_by 50 [get_pins {main_clock|clk_out_reg|q}]
create_generated_clock -name vga_clk -source [get_ports {clk}] -divide_by 2 [get_pins {vga_clock|clk_out_reg|q}]
create_generated_clock -name newline -source [get_pins {vga_clock|clk_out_reg|q}] -divide_by 1600 [get_pins {vga|horizontal|newline_out|q}]
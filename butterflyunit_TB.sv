//Compare results using butterfly_test.py

`define tmax 24'd131071
`define tmin -24'd131072

module butterflyunit_TB;
		
	reg [23:0] A_t_real, A_t_imag, B_t_real, B_t_imag, W_real, W_imag;
	reg [23:0] A_f_real, A_f_imag, B_f_real, B_f_imag;
	
	butterflyunit UUT( {A_t_real, A_t_imag}, {B_t_real, B_t_imag}, {W_real, W_imag}, {A_f_real, A_f_imag}, {B_f_real, B_f_imag});
	
	initial begin
	
		A_t_real = `tmax;
		A_t_imag = `tmax;
		B_t_real = `tmax;
		B_t_imag = `tmax;
		W_real = 24'h7fffff;	//0 degrees
		W_imag = 24'h000000;	//PASS
		#50;  
		W_real = 24'h7641b3;	//-22.5 degrees
		W_imag = 24'hcf043e;	//PASS
		#50; 
		W_real = 24'h5a827a;	//-45 degrees
		W_imag = 24'ha57d86;	//PASS
		#50; 
		W_real = 24'h30fbc2;	//-67.5 degrees
		W_imag = 24'h89be4d;	//PASS
		#50; 
		W_real = 24'h000000;	//-90 degrees
		W_imag = 24'h800000;	//PASS
		#50; 
		W_real = 24'hcf043e;	//-112.5 degrees
		W_imag = 24'h89be4d;	//PASS
		#50;  
		W_real = 24'ha57d86;	//-135 degrees
		W_imag = 24'ha57d86;	//PASS
		#50; 
		W_real = 24'h89be4d;	//-157.5 degrees
		W_imag = 24'hcf043e;	//PASS
		#100; 
		
		A_t_real = `tmax;
		A_t_imag = `tmax;
		B_t_real = `tmin;
		B_t_imag = `tmin;
		W_real = 24'h7fffff;	//0 degrees
		W_imag = 24'h000000;	//PASS
		#50;  
		W_real = 24'h7641b3;	//-22.5 degrees
		W_imag = 24'hcf043e;	//PASS
		#50; 
		W_real = 24'h5a827a;	//-45 degrees
		W_imag = 24'ha57d86;	//PASS
		#50; 
		W_real = 24'h30fbc2;	//-67.5 degrees
		W_imag = 24'h89be4d;	//PASS
		#50; 
		W_real = 24'h000000;	//-90 degrees
		W_imag = 24'h800000;	//PASS
		#50; 
		W_real = 24'hcf043e;	//-112.5 degrees
		W_imag = 24'h89be4d;	//PASS
		#50;  
		W_real = 24'ha57d86;	//-135 degrees
		W_imag = 24'ha57d86;	//PASS
		#50; 
		W_real = 24'h89be4d;	//-157.5 degrees
		W_imag = 24'hcf043e;	//PASS
		#100; 
		
		A_t_real = `tmax;
		A_t_imag = `tmin;
		B_t_real = `tmin;
		B_t_imag = `tmax;
		W_real = 24'h7fffff;	//0 degrees
		W_imag = 24'h000000;	//PASS
		#50;  
		W_real = 24'h7641b3;	//-22.5 degrees
		W_imag = 24'hcf043e;	//PASS
		#50; 
		W_real = 24'h5a827a;	//-45 degrees
		W_imag = 24'ha57d86;	//PASS
		#50; 
		W_real = 24'h30fbc2;	//-67.5 degrees
		W_imag = 24'h89be4d;	//PASS
		#50; 
		W_real = 24'h000000;	//-90 degrees
		W_imag = 24'h800000;	//PASS
		#50; 
		W_real = 24'hcf043e;	//-112.5 degrees
		W_imag = 24'h89be4d;	//PASS
		#50;  
		W_real = 24'ha57d86;	//-135 degrees
		W_imag = 24'ha57d86;	//PASS
		#50; 
		W_real = 24'h89be4d;	//-157.5 degrees
		W_imag = 24'hcf043e;	//PASS
		#100; 
		
		A_t_real = `tmin;
		A_t_imag = `tmin;
		B_t_real = `tmin;
		B_t_imag = `tmin;
		W_real = 24'h7fffff;	//0 degrees
		W_imag = 24'h000000;	//PASS
		#50;  
		W_real = 24'h7641b3;	//-22.5 degrees
		W_imag = 24'hcf043e;	//PASS
		#50; 
		W_real = 24'h5a827a;	//-45 degrees
		W_imag = 24'ha57d86;	//PASS
		#50; 
		W_real = 24'h30fbc2;	//-67.5 degrees
		W_imag = 24'h89be4d;	//PASS
		#50; 
		W_real = 24'h000000;	//-90 degrees
		W_imag = 24'h800000;	//PASS
		#50; 
		W_real = 24'hcf043e;	//-112.5 degrees
		W_imag = 24'h89be4d;	//PASS
		#50;  
		W_real = 24'ha57d86;	//-135 degrees
		W_imag = 24'ha57d86;	//PASS
		#50; 
		W_real = 24'h89be4d;	//-157.5 degrees
		W_imag = 24'hcf043e;	//PASS
		#100; 
		
	
	#10;
	end
							 
endmodule 
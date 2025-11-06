`timescale 1 ps / 1 ps

//this module connects the datapath and the control modules and serves as our test of the algorithm
//A: 8 bit input
//ready: ready signal
//done: done signal
//result: 4 bit result
module task1_connect(input logic s, reset, CLOCK_50,
						input logic [7:0] A,
						output logic ready, done,
						output logic [3:0] result);
						
	
	//intermediate status signals
	logic load_A, A_zero, shift_A, incr_result;
	logic A0;
	
	//control module
	task1_control control (.*);
	
	//datapath module
	task1_datapath datapath (.*);
	
endmodule //task1_connect

//this test bench tests our algorithm. We define the signals, instantiate task1_connect, 
//define a clock, and test the algorithm on three inputs and seeing if it outputs the correct result
module task1_connect_tb();

	logic s, reset, CLOCK_50;
	logic [7:0] A;
	logic ready, done;
	logic [3:0] result;
	
	task1_connect please_work (.*);
	
	parameter CLOCK_PERIOD=100;  

   initial begin   
       CLOCK_50 <= 0;  
       forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;  
   end  

	initial begin 
	
		//should output 4
		A = 8'b11010100;
		reset = 1; s = 0;	@(posedge CLOCK_50);
		reset = 0;			@(posedge CLOCK_50);
		s = 1;				@(posedge CLOCK_50);
		s = 0;				
		repeat(30)		@(posedge CLOCK_50);
		
		//should output 1
		A = 8'b00000001;
		reset = 1; s = 0;	@(posedge CLOCK_50);
		reset = 0;			@(posedge CLOCK_50);
		s = 1;				@(posedge CLOCK_50);
		s = 0;				
		repeat(30)		@(posedge CLOCK_50);
		
		//should output 8
		A = 8'b11111111;
		reset = 1; s = 0;	@(posedge CLOCK_50);
		reset = 0;			@(posedge CLOCK_50);
		s = 1;				@(posedge CLOCK_50);
		s = 0;				
		repeat(30)		@(posedge CLOCK_50); 
								
		$stop;
		
	end
endmodule //task1_connect_tb

 
`timescale 1 ps / 1 ps

//this is the module which connects the control and datapath modules
//A: our 8 bit input
//ready: ready signal
//done: done signal
//Loc: address
module task2_connect(input logic s, reset, CLOCK_50,
						input logic [7:0] A,
						output logic ready, done, found,
						output logic [4:0] Loc);
						
	
	//intermediate status signals
	logic load_regs, set_found, set_mid, set_right, set_left;
	logic mid_lt_In, addr_eq_In, left_gt_right;
	
	logic [4:0] mid;
	
	//assigns the address/loc to mid: (left + right)/2
	assign Loc = mid;
	
	//instantiate control module
	task2_control control (.*);
	
	//instantiate datapath module
	task2_datapath datapath (.*);
	
endmodule

//this testbench allows us to simulate our binary search algorithm
//we define the signaals
//we instantiate the module
//we have a simulated clock
//we test various values and see if the algorithm can find them in a 32x8 RAM module
module task2_connect_tb();

	logic s, reset, CLOCK_50;
	logic [7:0] A;
	logic ready, done, found;
	logic [4:0] Loc;
	
	task2_connect work (.*);
	
	parameter CLOCK_PERIOD=100;  

   initial begin   
       CLOCK_50 <= 0;  
       forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;  
   end  

	initial begin 
	//for all of these it should output found
	
		A = 8'b00001111;
		reset = 1; s = 0;	@(posedge CLOCK_50);
		reset = 0;			@(posedge CLOCK_50);
		s = 1;				@(posedge CLOCK_50);
		s = 0;				
		repeat(30)		@(posedge CLOCK_50);
		
		A = 8'b00001110;
		reset = 1; s = 0;	@(posedge CLOCK_50);
		reset = 0;			@(posedge CLOCK_50);
		s = 1;				@(posedge CLOCK_50);
		s = 0;				
		repeat(30)		@(posedge CLOCK_50);
		
		A = 8'b00000001;
		reset = 1; s = 0;	@(posedge CLOCK_50);
		reset = 0;			@(posedge CLOCK_50);
		s = 1;				@(posedge CLOCK_50);
		s = 0;				
		repeat(30)		@(posedge CLOCK_50);
								
		$stop;
		
	end
endmodule //task2_connect

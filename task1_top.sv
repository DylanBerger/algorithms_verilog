//this is the top level module which connects our algorithm to the DE1 board (i.e switches, key buttons, etc)
module task1_top(CLOCK_50, SW, KEY, LEDR, HEX0);
	input CLOCK_50; 
	input [9:0] SW; 
	input [3:0] KEY; 
	output [9:0] LEDR; 
	output [6:0] HEX0; 

	logic ready;
	logic [3:0] result;
	
	//instantiates the algorithm and defines what we will use as the input/output signals
	task1_connect wowowow (.s(KEY[3]), .reset(KEY[0]), .CLOCK_50(CLOCK_50), .A(SW[7:0]), .ready, .done(LEDR[9]), .result);
	
	//connects the result to hex display 0
	seg7 h0 (.hex(result), .leds(HEX0));
	
endmodule //task1_top
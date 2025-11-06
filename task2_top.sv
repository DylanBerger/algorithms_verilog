//this is the top level module that instantiates our binary search algorithm and connects its input/output signals
//to various parts of the DE1 board
module task2_top(CLOCK_50, SW, KEY, Loc, LEDR, HEX1, HEX0);
	input CLOCK_50; 
	input [9:0] SW; 
	input [3:0] KEY;
   input [4:0] Loc;
	output [9:0] LEDR; 
	output [6:0] HEX0, HEX1; 

	//intermediate status signals
	logic ready, key3_from_dff;
	
	//helps us split found address to two hex displays
	logic [3:0] first_hex;
   logic [3:0] second_hex;
	
	//double flip flop key3 input to combat metastability
	doubleFlipFlop flip (.clock(CLOCK_50), .reset(KEY[0]), .keys(KEY[3]), .out(key3_from_dff));
	
	//instantiate the algorithm
	task2_connect wowowow (.s(key3_from_dff), .reset(KEY[0]), .CLOCK_50(CLOCK_50), .A(SW[7:0]), .ready, .done(LEDR[9]), .found(LEDR[0]));
	
	//always comb block as first_hex and second_hex are constantly changing
	always_comb begin
	
        first_hex  = Loc[3:0];
        second_hex = {3'b000, Loc[4]};
		  
   end
	
	//hex displays
	seg7 h0 (.hex(first_hex), .leds(HEX0));
	seg7 h1 (.hex(second_hex), .leds(HEX1));
	
endmodule //task2_top
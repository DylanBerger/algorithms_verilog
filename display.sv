//This module handles our counting and hex logic
module display (
    input  logic       clk, rst,
    input  logic       inc, dec,
    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

    logic [4:0] count;

    logic [3:0] ones, tens, hex2, hex3, hex4, hex5;
	
	
	 //this always_ff block handles when we decrease or increase the count (exiting/entering respectively) 
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 5'd0;
        end 
        else if (inc && count < 16) begin
            count <= count + 1;
        end 
        else if (dec && count > 0) begin
            count <= count - 1;
        end
    end

   //this always_comb block dictates what the hex displays show depending on the count.
    always_comb begin
	 
		  ones = 4'd0;
		  tens = 4'd0;
		  hex2 = 4'd0;
		  hex3 = 4'd0;
		  hex4 = 4'd0;
		  hex5 = 4'd0;
		  //if the count is 0 (the lot is empty), display '0CLEAR'
        if (count == 0) begin
            
            ones = 4'd0;  // 0
            tens = 4'd10; // C
            hex2 = 4'd9;  // L
            hex3 = 4'd11; // E
				hex4 = 4'd12; // A
				hex5 = 4'd13; // R
				
        end 
		  //if the count is 16 (full lot), display '16FULL'
        else if (count == 16) begin
            
            ones = 4'd1;  // 1
            tens = 4'd6;  // 6
            hex2 = 4'd7;  // F
            hex3 = 4'd8;  // U
				hex4 = 4'd9;  // L
            hex5 = 4'd9;  // L
        end 
		  //handles the transition between 9-10 and vice versa
        else begin
            
            if (count < 10) begin
                tens = 0;
                ones = count;
            end else begin
                tens = 1;
                ones = count - 10;
            end
        end
    end
	
	 //instantiate the HexDisplay module which actually drives the HEX displays
    HexDisplay h0 (.value(ones), .segments(HEX0));
    HexDisplay h1 (.value(tens), .segments(HEX1));
    HexDisplay h2 (.value(hex2), .segments(HEX2));
    HexDisplay h3 (.value(hex3), .segments(HEX3));
    HexDisplay h4 (.value(hex4), .segments(HEX4));
    HexDisplay h5 (.value(hex5), .segments(HEX5));

endmodule




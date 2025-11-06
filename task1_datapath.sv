//This module is the datapath for our circuit
//incr_result: used to increment the result (# of 1's in the input)
//A: our 8 bit input
//A0: the 0th bit of A
//A_zero: true when A is all zeros, false otherwise
//result: the # of 1's in our 8 bit input
module task1_datapath(
    input  logic CLOCK_50, reset, load_A, shift_A, done, incr_result,
	 input logic [7:0] A,
	 output logic A0, A_zero,
	 output logic [3:0] result
               
);
	
	logic [7:0] In; //assigned to A, allowing us to manipulate the value
	assign A0 = In[0]; //defines A0
	assign A_zero = (A == 0); //defines A_zero
	
	//this always ff block handles the data when we recieve the control signals
	//includes incr_result which increments result by 1
	//load_A which loads In for us to perfom operations on
	//shift_A which shifts A/In 
	always_ff @(posedge CLOCK_50) begin 
        if (reset) begin
		  
            result <= 4'b0000;
            In <= 8'd0;
				
        end else begin
            
            if (incr_result) begin
				
                result <= result + 1'b1;
					 
            end
            
            if (load_A) begin
				
                In <= A;
					 
            end else if (shift_A) begin
				
                In <= In >> 1;
					 
            end
        end
    end 

endmodule //task1_datapath
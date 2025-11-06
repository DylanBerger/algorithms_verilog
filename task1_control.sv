//this module defines our states and control signals
//s: start signal
//A_zero: true when A is all zeroes, false otherwise
//A0: the first (0th) digit of A
//A: our eight bit input
//load_A: tells the datapath when to load A into the system
//shift_A: tells the datapath when to shift A
//ready: ready signal
//done: done signal
//incr_result: tells the datapath when we can increment result
module task1_control(
    input  logic CLOCK_50, reset, s, A_zero, A0,
	 input logic [7:0] A,
	 output logic load_A, shift_A, ready, done, incr_result
               
);

	 //three states
    enum {S_1, S_2, S_3} ps, ns;
	 
	 //present state is the first state upon reset, otherwise the present 
	 //state is the next state
	 always_ff @(posedge CLOCK_50 or posedge reset) begin
		 if (reset) begin
		 
			  ps <= S_1;
			  
		 end else begin
		 
			  ps <= ns;
		 end
	 end
	 
	 //our state logic
    always_comb begin
        case (ps)
            S_1: begin
                if (s)
                    ns = S_2;
                else
                    ns = S_1;
            end

            S_2: begin
                if (A_zero)
                    ns = S_3;
						  
                else if (!A_zero & ~A0)
					 
                    ns = S_2;
					 else 
						  
						  ns = ps;
            end

            S_3: begin
                if (s)
                    ns = S_3;
                else
                    ns = S_1;
            end

            default: ns = S_1;
				
        endcase
    end

//defining our control signals
assign load_A = (ps == S_1) & (s);
assign shift_A = (ps == S_2);
assign done = (ps == S_3);
assign incr_result = (ps == S_2) & (A_zero == 0) & (A0 == 1);
assign ready = (ps == S_1);

endmodule //task1_control

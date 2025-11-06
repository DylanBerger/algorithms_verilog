//this is our control module for our binary search algoritm
//A: our 8 bit input
//addr_eq_In: true if current address contains our input
//left_gt_right: true if the left address is greater than the right address
//mid_lt_In: true if the value in the mid address is less than the value we are searching for
//load_regs: to load our values 
//set_mid: set the mid address
//set_left: set the left address
//set_right: set the right address
//done: done signal
//set_found: set found when we found our input in the RAM module
module task2_control(
    input  logic CLOCK_50, reset, s,  
	 input logic [7:0] A,
	 input logic addr_eq_In, left_gt_right, mid_lt_In, 
	 output logic load_regs, set_mid, set_left, set_right, done, set_found
               
);
	 //three states: idle, searching, and done
    enum {s_idle, s_search, s_done} ps, ns;
	 
	 //on reset, present state is the idle state, otherwise it is the next intended state
	 always_ff @(posedge CLOCK_50 or posedge reset) begin
		 if (reset) begin
		 
			  ps <= s_idle;
			  
		 end else begin
		 
			  ps <= ns;
		 end
	 end
	 
	 //state logic for our binary search algorithm
    always_comb begin
        case (ps)
            s_idle: begin
                if (s)
                    ns = s_search;
                else
                    ns = s_idle;
            end

            s_search: begin
                if (addr_eq_In | left_gt_right)
					 
                    ns = s_done;
						  
					 else 
						  ns = s_search;
						  
            end

            s_done: begin
                if (s)
					 
                    ns = s_done;
						  
                else
					 
                    ns = s_idle;
            end

            default: ns = s_idle;
				
        endcase
    end

//our control signals
assign load_regs = (ps == s_idle) & (s);
assign set_mid = (ps == s_search) & (ns == s_search);
assign set_found = (ps == s_done) & (addr_eq_In);
assign set_right = (ps == s_search) & (ns == s_search) & ~(mid_lt_In);
assign set_left = (ps == s_search) & (ns == s_search) & (mid_lt_In);
assign done = (ps == s_done);
assign ready = (ps == s_idle);

endmodule //task2_control
//this is our datapath for our binary search algorithm
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
//found: set to 1 when we found our value
//mid: the address we search
module task2_datapath(
    input  logic CLOCK_50, reset, load_regs, set_mid, set_left, set_right, done, set_found,
	 input logic [7:0] A,
	 output logic mid_lt_In, addr_eq_In, left_gt_right, found,
	 output logic [4:0] mid = 5'b01111
               
);
	//intermediate signals
	logic [7:0] In, out;
	
	//left as the first address in our RAM
	logic [4:0] left = 5'b00000;
	
	//right as the last address in our ram (31)
	logic [4:0] right = 5'b11111;
	
	//delay to help timing
	logic delay;
	
	//this defines what we do to our data signals when we get a control signal
	always_ff @(posedge CLOCK_50) begin 
		 if (reset) begin
			  In    <= 8'd0;
			  found <= 1'b0;
			  left  <= 5'b00000;
			  right <= 5'b11111;
			  mid   <= 5'b01111;
			  delay  <= 1'b0;           
		 end 
		 else if (load_regs) begin
			  In    <= A;               
			  found <= 1'b0;
			  left  <= 5'b00000;
			  right <= 5'b11111;
			  mid   <= 5'b01111;
			  delay  <= 1'b0;
           
		 end else if (set_found)
		 
				found <= 1'b1;
		 
		 //set left, right, and mid
		 else begin
			  if (delay) begin
			  
					if (set_left)
						 left <= mid + 5'd1;

					if (set_right)
						 right <= mid - 5'd1;

					if (set_mid)
						 mid <= (left + right) >> 1;

					delay <= 1'b0;         
			  end 
			  else begin
					delay <= 1'b1;
			  end
		 end
	end
	
	//signals for our control module
	assign addr_eq_In = (out == In);
	assign left_gt_right = (left > right);
	assign mid_lt_In = (In > out);

	//ram instantiation so we can search addresses and get their contents
	task_ram ram (.address(mid), .clock(CLOCK_50), .data(8'd0), .wren(1'b0), .q(out));	

endmodule //task2_datapath
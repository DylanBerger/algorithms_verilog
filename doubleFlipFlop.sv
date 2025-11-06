module doubleFlipFlop (clock, reset, keys, out);

input logic clock, reset;
input logic keys;
output logic out;

logic out_ff1;

	always_ff @(posedge clock) begin
		out_ff1 <= keys;
		out <= out_ff1;
	end
	
endmodule
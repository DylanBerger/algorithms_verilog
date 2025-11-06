//This module acts as a dictionary to map numbers/states too the corresponding hex led combination
//These combinations are the numbers and letters we use 
module HexDisplay (
    input  logic [3:0] value,     // 0–13 valid
    output logic [6:0] segments   // active-low segments
);
    always_comb begin
        case (value)
            4'd0: segments = 7'b100_0000; // 0
            4'd1: segments = 7'b111_1001; // 1
            4'd2: segments = 7'b010_0100; // 2
            4'd3: segments = 7'b011_0000; // 3
            4'd4: segments = 7'b001_1001; // 4
            4'd5: segments = 7'b001_0010; // 5
            4'd6: segments = 7'b000_0010; // 6
            4'd7: segments = 7'b000_1110; // F
            4'd8: segments = 7'b100_0001; // U
            4'd9: segments = 7'b100_0111; // L
            4'd10: segments = 7'b100_0110; // C
            4'd11: segments = 7'b000_0110; // E
            4'd12: segments = 7'b000_1000; // A
            4'd13: segments = 7'b111_1010; // R
            default: segments = 7'b111_1111; // blank/off
        endcase
    end
endmodule //hex_display

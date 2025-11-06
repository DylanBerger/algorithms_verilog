//this top of the top level module connects tasks 1 and 2 so we can switch between them via SW[9]
module connect_task1_task2(
    input  logic        CLOCK_50,
    input  logic [9:0]  SW,
    input  logic [3:0]  KEY,
    input  logic [4:0]  Loc,
    output logic [9:0]  LEDR,
    output logic [6:0]  HEX1,
    output logic [6:0]  HEX0
);

    logic [9:0] led_task1, led_task2;
    logic [6:0] hex0_task1;
    logic [6:0] hex1_task2, hex0_task2;

    task1_top t1 (
        .CLOCK_50(CLOCK_50),
        .SW(SW),
        .KEY(KEY),
        .LEDR(led_task1),
        .HEX0(hex0_task1)
    );

    task2_top t2 (
        .CLOCK_50(CLOCK_50),
        .SW(SW),
        .KEY(KEY),
        .Loc(Loc),
        .LEDR(led_task2),
        .HEX1(hex1_task2),
        .HEX0(hex0_task2)
    );
	 
	 //used to switch between algorithms
	 assign LEDR = SW[9] ? led_task2 : led_task1;
    assign HEX0 = SW[9] ? hex0_task2 : hex0_task1;
    assign HEX1 = SW[9] ? hex1_task2: 7'b0000000;

endmodule

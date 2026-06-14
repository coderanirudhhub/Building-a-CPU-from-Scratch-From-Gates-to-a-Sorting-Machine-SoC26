`timescale 1ns/1ps

module decoder_tb;

reg [5:0] opcode;
wire [22:0] dec;

// instantiating the design
decoder uut (
    .opcode(opcode),
    .dec(dec)
);

initial begin
    //vcd outputs
    $dumpfile("decoder.vcd");
    $dumpvars(0, decoder_tb);

    opcode = 0; #10; // Noop
    
    opcode = 6'b000100; #10;
    opcode = 6'b000101; #10;
    opcode = 6'b000110; #10;
    opcode = 6'b000111; #10;

    opcode = 6'b001000; #10;
    opcode = 6'b001100; #10;

    opcode = 6'b010000; #10;
    opcode = 6'b010100; #10;
    opcode = 6'b011000; #10;
    opcode = 6'b011100; #10;
    opcode = 6'b110000; #10;
    opcode = 6'b110001; #10;
    opcode = 6'b110100; #10;

    opcode = 6'b100000; #10;
    opcode = 6'b100001; #10;
    opcode = 6'b100010; #10;
    opcode = 6'b100011; #10;

    opcode = 6'b111000; #10;
    opcode = 6'b111100; #10;
    opcode = 6'b111101; #10;
    opcode = 6'b111110; #10;
    opcode = 6'b111111; #10;

    #20;
    $display("done testing");
    $finish;
end

endmodule

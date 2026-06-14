module decoder(
    input [5:0] opcode,
    output reg [22:0] dec
);

always @(*) begin
    dec = 0; // shorthand for 23'b0
    
    case(opcode)
        6'b000000: dec[0] = 1; // noop
        
        // inputs
        6'b000100: dec[1] = 1;
        6'b000101: dec[2] = 1;
        6'b000110: dec[3] = 1;
        6'b000111: dec[4] = 1;

        6'b001000: dec[5] = 1; // move
        6'b001100: dec[6] = 1; // loadi

        // alu
        6'b010000: dec[7] = 1; // add
        6'b010100: dec[8] = 1;
        6'b011000: dec[9] = 1; // sub
        6'b011100: dec[10] = 1;

        //Memory
        6'b100000: dec[11] = 1;
        6'b100001: dec[12] = 1;
        6'b100010: dec[13] = 1;
        6'b100011: dec[14] = 1;

        6'b110000: dec[15] = 1; // shiftl
        6'b110001: dec[16] = 1; // shiftr
        6'b110100: dec[17] = 1; // cmp

        // branches
        6'b111000: dec[18] = 1; // jump
        6'b111100: dec[19] = 1; //BRE
        6'b111101: dec[20] = 1;//BRNE
        6'b111110: dec[21] = 1;//BRZ
        6'b111111: dec[22] = 1;//BRGE
    endcase
end
endmodule

// Week 2 — 8-bit ALU
// op: 000=ADD 001=SUB 010=AND 011=OR 100=XOR 101=SHIFTL 110=SHIFTR
// Run: iverilog -o sim ../testbenches/tb_alu.v alu.v && vvp sim

module alu(
    input  [7:0]     a, b,
    input  [2:0]     op,
    output reg [7:0] result,
    output           zero,
    output reg       carry,
    output reg       overflow
);
      assign zero = (result == 8'b0000_0000);

    always @(*) begin
        carry    = 1'b0;
      overflow = 1'b0;

    if (op == 3'b000) begin
            {carry, result} = a + b;
            overflow = (a[7] == b[7]) && (result[7] != a[7]);
        end 
    else if(op == 3'b001) begin
            result = a - b;
            carry  = (a < b);
            overflow = (a[7] != b[7]) && (result[7] != a[7]);
        end 
      else if(op == 3'b010)
    result = a & b; 
    else if(op == 3'b011)
       result = a | b;
      else if (op == 3'b100)
     result = a ^ b;
    else if (op == 3'b101)
     result = a << 1;
    else if (op == 3'b110)
     result = a >> 1;
    end
endmodule

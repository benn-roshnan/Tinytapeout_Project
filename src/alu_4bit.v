// ============================================================
//  4-bit ALU
//  Inputs : opcode [1:0], A [3:0], B [3:0]
//  Output : result [7:0]   (8 bits to hold multiplication)
//  Opcodes: 2'b00 = ADD
//           2'b01 = SUB
//           2'b10 = MUL
//           2'b11 = DIV
// ============================================================

module alu_4bit (
    input  [1:0] opcode,   // 2-bit operation selector
    input  [3:0] A,        // 4-bit operand A
    input  [3:0] B,        // 4-bit operand B
    output reg [7:0] result // 8-bit result (wide enough for MUL)
);

    always @(*) begin
        case (opcode)
            2'b00: result = A + B;          // Addition
            2'b01: result = A - B;          // Subtraction
            2'b10: result = A * B;          // Multiplication
            2'b11: begin
                if (B != 0)
                    result = A / B;         // Division (integer)
                else
                    result = 8'hFF;         // Division by zero guard → 0xFF
            end
            default: result = 8'b0;
        endcase
    end

endmodule

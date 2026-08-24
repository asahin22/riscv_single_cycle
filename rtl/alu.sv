module alu (
    input  logic [31:0] rs1,
    input  logic [31:0] rs2,
    input  logic [2:0]  alu_control,
    output logic [31:0] result,
    output logic zero
);
    always_comb begin
        case (alu_control)
            3'b000: result=rs1 + rs2; 
            3'b001: result=rs1 - rs2; 
            3'b010: result=rs1 & rs2; 
            3'b011: result=rs1 | rs2; 
            3'b100: result=($signed(rs1) < $signed(rs2)) ? 32'd1 : 32'd0;
            3'b101: result=rs2; 
            default: result = 32'd0;
        endcase
    end
    assign zero=(result==32'd0);
endmodule
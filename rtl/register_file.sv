module register_file (
    input logic clk,
    input logic [4:0] rs1,
    input logic [4:0] rs2,
    input logic RegWrite,
    input logic [4:0] rd,
    input logic [31:0] write_data,
    output logic [31:0] rs1_data,
    output logic [31:0] rs2_data
);
    logic [31:0] regs [0:31];
    assign rs1_data=(rs1 == 5'd0) ? 32'd0 : regs[rs1];
    assign rs2_data=(rs2 == 5'd0) ? 32'd0 : regs[rs2];
    always_ff @(posedge clk) begin
        if (RegWrite && (rd != 5'd0))
            regs[rd] <= write_data;
    end
endmodule
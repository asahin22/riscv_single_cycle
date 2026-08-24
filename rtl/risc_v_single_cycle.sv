module risc_v_single_cycle (
    input logic clk,
    input logic reset
);
    logic [31:0] pc_value;
    logic [31:0] pc4;
    logic [31:0] instruction;
    logic [31:0] rd1;
    logic [31:0] rd2;
    logic [31:0] ImmExt;
    logic [31:0] alu_src_b;
    logic [31:0] alu_result;
    logic zero;
    logic [31:0] read_data;
    logic [31:0] result;
    logic RegWrite;
    logic MemWrite;
    logic ALUSrc;
    logic Branch;
    logic Jump;
    logic [1:0] ResultSrc;
    logic [2:0] ImmSrc;
    logic [2:0] alu_control;

pc pc_unit(
    .clk(clk),
    .reset(reset),
    .Branch(Branch),
    .Jump(Jump),
    .zero(zero),
    .ImmExt(ImmExt),
    .pc4(pc4),
    .pc(pc_value)
);

instruction_memory instruction_memory(
    .pc(pc_value),
    .instruction(instruction)
);

register_file rf(
    .rs1(instruction[19:15]),
    .rs2(instruction[24:20]),
    .clk(clk),
    .RegWrite(RegWrite),
    .rd(instruction[11:7]),
    .write_data(result),
    .rs1_data(rd1),
    .rs2_data(rd2)
);

immediate_generator immediate_generator(
    .instruction(instruction),
    .ImmSrc(ImmSrc),
    .ImmExt(ImmExt)
);
data_memory data_memory(
    .clk(clk),
    .MemWrite(MemWrite),
    .address(alu_result),
    .write_data(rd2),
    .read_data(read_data)
);
control_unit control_unit(
    .opcode(instruction[6:0]),
    .funct3(instruction[14:12]),
    .funct7(instruction[31:25]),
    .RegWrite(RegWrite),
    .alu_control(alu_control),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .Branch(Branch),
    .Jump(Jump),
    .ResultSrc(ResultSrc),
    .ImmSrc(ImmSrc)
);

assign alu_src_b=ALUSrc ? ImmExt : rd2;
alu alu_unit(
    .rs1(rd1),
    .rs2(alu_src_b),
    .alu_control(alu_control),
    .zero(zero),
    .result(alu_result)
);
    always_comb begin
        case (ResultSrc)
            2'b00: result=alu_result;
            2'b01: result=read_data;
            2'b10: result=pc4;
            default: result=32'b0;
        endcase
    end
endmodule
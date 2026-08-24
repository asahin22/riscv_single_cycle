module pc (
    input  logic clk,
    input  logic reset,
    input logic Branch,
    input logic Jump,
    input logic zero, 
    input logic [31:0] ImmExt,
    output  logic [31:0] pc4,
    output logic [31:0] pc
); 
    logic [31:0] pc_next;
    logic [31:0] pc_target;
    always_comb begin
        pc4=pc+32'd4;
        pc_target=pc+ImmExt;
        if ((Branch&zero) | Jump)
            pc_next=pc_target;
        else
            pc_next=pc4;
    end
    always_ff @ (posedge clk) begin
        if (reset)
            pc <= 32'b0;
        else
            pc <= pc_next;
    end

endmodule
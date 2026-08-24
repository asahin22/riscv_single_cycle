module data_memory (
    input logic clk,
    input logic MemWrite,
    input logic [31:0] address,
    input logic [31:0] write_data,
    output logic [31:0] read_data
);
    logic [31:0] memory [0:255]; //256 32-bit data 
    always_ff @(posedge clk) begin
        if (MemWrite) begin
                memory[address[9:2]]<=write_data;
        end
    end
    assign read_data = memory[address[9:2]]; //always comb raises warning
endmodule
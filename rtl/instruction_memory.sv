module instruction_memory(
    input logic [31:0] pc, 
    output logic [31:0] instruction
);
    logic [31:0] memory [0:1023];
    assign instruction = memory[pc[11:2]]; //always_com raises error, using assign
endmodule
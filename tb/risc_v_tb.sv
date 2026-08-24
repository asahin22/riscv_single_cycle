module risc_v_single_cycle_tb;
    logic clk;
    logic reset;
    risc_v_single_cycle dut (
        .clk(clk),
        .reset(reset)
    );
    // 10 time-unit clock period
    always #5 clk = ~clk;
    initial begin
        clk   = 1'b0;
        reset = 1'b1;
        dut.instruction_memory.memory[0] = 32'h00500093; // addi x1, x0, 5
        dut.instruction_memory.memory[1] = 32'h00500113; // addi x2, x0, 5
        dut.instruction_memory.memory[2] = 32'h00208463; // beq  x1, x2, +8
        dut.instruction_memory.memory[3] = 32'h00100193; // addi x3, x0, 1  
        dut.instruction_memory.memory[4] = 32'h00900193; // addi x3, x0, 9
        #12;
        reset = 1'b0;
        #60;
        $display("x1 = %0d", dut.rf.regs[1]);
        $display("x2 = %0d", dut.rf.regs[2]);
        $display("x3 = %0d", dut.rf.regs[3]);
        $finish;
    end

endmodule
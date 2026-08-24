module pc_tb;

    logic clk;
    logic reset;
    logic [31:0] pc_next;
    logic [31:0] pc;

    pc dut (
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next),
        .pc(pc)
    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        reset = 1;
        pc_next = 0;

        #10;

        reset = 0;
        pc_next = 4;

        #10;

        pc_next = 8;

        #10;

        pc_next = 12;

        #10;

        $finish;

    end
    initial begin
        $monitor(
            "time=%0t clk=%b reset=%b pc_next=%0d pc=%0d",
            $time,
            clk,
            reset,
            pc_next,
            pc
        );
    end

endmodule
module immediate_generator (
    input logic [31:0] instruction,
    input logic [2:0] ImmSrc, //contol unit output, which format
    output logic [31:0] ImmExt //imm that will be used
);
    always_comb begin
        case (ImmSrc)
            3'b000: begin //R-type
                ImmExt = 32'b0;
            end
            3'b001: begin //S-type
                ImmExt = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            end
            3'b010: begin //I-type
                ImmExt = {{20{instruction[31]}},instruction[31:20]};
            end
            3'b011: begin //B-type
                ImmExt = {{20{instruction[31]}},instruction[7], instruction[30:25], instruction[11:8],1'b0};
            end         
            3'b100: begin //J-type
                ImmExt = {
                    {11{instruction[31]}},instruction[31],instruction[19:12],instruction[20],instruction[30:21],1'b0
                };            
            end     
            3'b110: begin //U-type
                ImmExt = {instruction[31:12],12'b0};
            end
            default: begin
                ImmExt=32'b0;
            end    
    
        endcase
    end
endmodule
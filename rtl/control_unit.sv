module control_unit (
    input logic [6:0] opcode,
    input logic [2:0] funct3,
    input logic [6:0] funct7,
    output logic RegWrite,
    output logic [2:0] alu_control,
    output logic MemWrite,
    output logic ALUSrc,
    output logic Branch,
    output logic Jump, 
    output logic [1:0] ResultSrc, //Reg file hangi sonuç yazılacak
    output logic [2:0] ImmSrc
);
    always_comb begin
        case (opcode)
            7'b0110011: begin //R-type
                case (funct3)
                    3'b000: begin
                        if (funct7==7'b0100000)
                            alu_control=3'b001; // SUB
                        else
                            alu_control=3'b000; // ADD
                    end

                    3'b111:
                        alu_control=3'b010; // AND

                    3'b110:
                        alu_control=3'b011; // OR

                    3'b010:
                        alu_control=3'b100; // SLT

                    default:
                        alu_control=3'b000;
                endcase

                RegWrite = 1'b1;
                MemWrite=1'b0;
                ALUSrc=1'b0;
                Branch=1'b0;
                Jump=1'b0;
                ImmSrc=3'b000;
                ResultSrc=2'b00;
            end
            7'b0010011: begin //I-type
                 case (funct3)
                    3'b000:
                        alu_control=3'b000; // ADDI

                    3'b111:
                        alu_control=3'b010; // ANDI

                    3'b110:
                        alu_control=3'b011; // ORI

                    3'b010:
                        alu_control=3'b100; // SLTI

                    default:
                        alu_control=3'b000;
                endcase
                RegWrite = 1'b1;
                MemWrite=1'b0;
                ALUSrc=1'b1;
                Branch=1'b0;
                Jump=1'b0;
                ImmSrc=3'b010;
                ResultSrc=2'b00;
            end 
            7'b0000011: begin
                RegWrite=1'b1;
                MemWrite=1'b0;
                ALUSrc=1'b1;
                Branch=1'b0;
                Jump= 1'b0;
                ImmSrc=3'b010; // I-type
                alu_control=3'b000; 
                ResultSrc=2'b01;
            end         
            7'b0100011: begin //S-type
                RegWrite = 1'b0;
                MemWrite=1'b1;
                ALUSrc=1'b1;
                Branch=1'b0;
                Jump=1'b0;
                ImmSrc=3'b001;
                alu_control=3'b000;
                ResultSrc=2'b00;
            end                
            7'b1100011: begin //B-type
                RegWrite = 1'b0;
                MemWrite=1'b0;
                ALUSrc=1'b0;
                Jump=1'b0;
                ResultSrc=2'b00;
                alu_control=3'b001; //SUB
                if (funct3==3'b000)
                    Branch=1'b1;    // BEQ
                else
                    Branch=1'b0;
                ImmSrc=3'b011;
            end
            7'b1101111: begin //J-type
                RegWrite = 1'b1;
                MemWrite=1'b0;
                ALUSrc=1'b0;
                Branch=1'b0;
                Jump=1'b1;
                ImmSrc=3'b100;
                ResultSrc=2'b10;
                alu_control=3'b000;
            end   
            7'b0110111: begin //U-type
                RegWrite=1'b1;
                MemWrite=1'b0;
                ALUSrc=1'b1;
                Branch=1'b0;
                ResultSrc=2'b00;
                Jump=1'b0;
                ImmSrc=3'b110;
                alu_control=3'b101;
            end     
            default: begin     
                RegWrite = 1'b0;
                MemWrite=1'b0;
                ALUSrc=1'b0;
                Branch=1'b0;
                Jump=1'b0;
                ImmSrc=3'b000;  
                alu_control=3'b000;
                ResultSrc=2'b00;
            end                    
        endcase
    end
endmodule

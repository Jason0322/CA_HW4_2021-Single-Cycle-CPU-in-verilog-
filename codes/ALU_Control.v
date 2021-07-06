
module ALU_Control(
    funct_i,
    ALUOp_i,
    ALUCtrl_o
);


input wire [9:0] funct_i; //funct7funct3
input wire [1:0]ALUOp_i;
output wire [2:0] ALUCtrl_o; //8 operations

reg [2:0] ALUCtrl;
assign ALUCtrl_o = ALUCtrl;

always @(funct_i) begin
  if (ALUOp_i == 2'b01 && funct_i[2:0] == 3'b000) 
    ALUCtrl = 3'b000;
  else begin
    case(funct_i)
      10'b0000000111 : ALUCtrl = 3'b001;    //and
      10'b0000000100 : ALUCtrl = 3'b010;    //xor
      10'b0000000001 : ALUCtrl = 3'b011;    //sll
      10'b0000000000 : ALUCtrl = 3'b100;    //add
      10'b0100000000 : ALUCtrl = 3'b101;    //sub
      10'b0000001000 : ALUCtrl = 3'b110;    //mul
      10'b0100000101 : ALUCtrl = 3'b111;    //srai
      default : begin 
        ALUCtrl = 3'b000;
        //$display("ALU control error");
      end
    endcase
  end
end

endmodule
module Control(
    Op_i,
    ALUOp_o,
    ALUSrc_o,
    RegWrite_o
);

// Ports
input    [6:0]      Op_i;     //opcode
output wire reg [1:0]      ALUOp_o;
output wire reg            ALUSrc_o;
output wire reg            RegWrite_o;

// Wires & Registers
// reg      [1:0]      ALUOp_o;
// reg                 ALUSrc_o;
// reg                 RegWrite_o;

// set controls
always@(Op_i) begin
  	case(Op_i)
		7'b0010011:            //I-type
      begin
  			ALUOp_o = 2'b01;
  			ALUSrc_o = 1'b1;
      end
		7'b0110011:            //R-type
      begin
  			ALUOp_o = 2'b00;
  			ALUSrc_o = 1'b0;
      end
	  endcase
    RegWrite_o = 1'b1;
end


endmodule

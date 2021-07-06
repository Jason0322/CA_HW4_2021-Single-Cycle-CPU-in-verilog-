module ALU(
	data1_i,
    data2_i,
    ALUCtrl_i,
    data_o,
    Zero_o   
);

input wire signed [31:0] data1_i;
input wire signed [31:0] data2_i;
input wire [2:0] ALUCtrl_i;
output wire signed [31:0] data_o;
output wire Zero_o;

reg [31:0] data;
assign data_o = data ;

reg z;
assign Zero_o = z;

//assign Zero_o = (data_o == 0);

always @(*) begin
	//Zero_o <= 0;
	case (ALUCtrl_i)
		3'b000: data = $signed(data1_i) + $signed(data2_i);     //addi
		3'b001: data = data1_i & data2_i;     //and
		3'b010: data = data1_i ^ data2_i;     //xor
		3'b011: data = data1_i << data2_i;    //sll
		3'b100: data = $signed(data1_i) + $signed(data2_i);     //add
		3'b101: data = $signed(data1_i) - $signed(data2_i);     //sub
		3'b110: data = $signed(data1_i) * $signed(data2_i);     //mul
		3'b111: data = $signed(data1_i) >>> data2_i[4:0];    //srai
		default: data = 0;
	endcase
	z=0;
end


endmodule
module Sign_Extend(
	input wire [11:0] data_i,
	input wire [2:0] funct3_i,
	output wire reg[31:0] data_o
);

always @(*) begin
	if (funct3_i==3'b101) begin
		data_o[4:0] = data_i[4:0];				//srai
		if (data_i[4]==0) begin
			data_o[31:5] = 27'b000000000000000000000000000;
		end
		else begin
			data_o[31:5] = 27'b111111111111111111111111111;
		end	
	end
	else begin
		data_o[11:0] = data_i;					//addi
		if(data_i[11]==0)
			data_o[31:12] = 20'b00000000000000000000;
		else
			data_o[31:12] = 20'b11111111111111111111;	
	end
end


endmodule
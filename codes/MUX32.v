module MUX32(
	data1_i,
	data2_i,
	select_i,
	data_o
);

input wire [31:0] data1_i,data2_i;
input wire		 select_i;

output wire reg [31:0] data_o;


always @(data1_i or data2_i) begin
	if (select_i) begin
		data_o = data2_i;
	end
	else 
		data_o = data1_i;
end

endmodule

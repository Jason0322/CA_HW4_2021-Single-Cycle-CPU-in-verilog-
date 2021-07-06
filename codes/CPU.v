module CPU
(
    clk_i, 
    rst_i,
    start_i
);

// Ports
input               clk_i;
input               rst_i;
input               start_i;

wire [2:0]  alu_ctrl;       //ALU_Control output and ALU input

wire [31:0] alu_result;     //ALU output, Registers input

wire zero;      //ALU output

wire [31:0] instr;          
//instructions: Instruction_Memory output -->
//inst[6:0] = Control input
//inst[19:15],[24:20],[11:7] = Registers input
//inst[31:20] = Sign_Extend input
//inst[31:25],[14:12] = ALU_Control input


wire [31:0] reg_data1_temp;     //Registers output,ALU input
wire [31:0] reg_data2_temp;     //Registers output, MUX32 input

wire [31:0] data_ext;   //Sign_extend output, MUX32 input

wire [31:0] PC_o;       //PC output, Adder input, Instruction_Memory input
wire [31:0] PC_i;       //Adder output, PC input

wire [1:0] ALUOp;       //Control output, ALU_Contol input
wire ctrl_alu_src;      //Control output, MUX32 input

wire ctrl_reg_write;    //Control output, registers input

wire [31:0] ALU_i1;     //MUX32 output, ALU input

Control Control( 
    .Op_i       (instr[6:0]),
    .ALUOp_o    (ALUOp),
    .ALUSrc_o   (ctrl_alu_src),
    .RegWrite_o (ctrl_reg_write)
);


Adder Add_PC(  
    .data1_in   (PC_o),
    .data2_in   (4),
    .data_o     (PC_i)
);


PC PC(  
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .pc_i       (PC_i),
    .pc_o       (PC_o)
);

Instruction_Memory Instruction_Memory( 
    .addr_i     (PC_o), 
    .instr_o    (instr)
);

Registers Registers(
    .clk_i      (clk_i),
    .RS1addr_i   (instr[19:15]),     
    .RS2addr_i   (instr[24:20]),    
    .RDaddr_i   (instr[11:7]),      
    .RDdata_i   (alu_result),       
    .RegWrite_i (ctrl_reg_write),   
    .RS1data_o   (reg_data1_temp),  
    .RS2data_o   (reg_data2_temp)   
);


MUX32 MUX_ALUSrc(
    .data1_i    (reg_data2_temp),
    .data2_i    (data_ext),
    .select_i   (ctrl_alu_src),   
    .data_o     (ALU_i1)  
);


Sign_Extend Sign_Extend(    
    .data_i     (instr[31:20]),     //imm
    .funct3_i   (instr[14:12]),
    .data_o     (data_ext)
);

  

ALU ALU(
    .data1_i    (reg_data1_temp),
    .data2_i    (ALU_i1),
    .ALUCtrl_i  (alu_ctrl),
    .data_o     (alu_result),
    .Zero_o     (zero)
);



ALU_Control ALU_Control(
    .funct_i    ({instr[31:25],instr[14:12]}),  
    .ALUOp_i    (ALUOp),    
    .ALUCtrl_o  (alu_ctrl)  
);

endmodule


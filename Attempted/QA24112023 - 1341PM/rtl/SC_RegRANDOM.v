
//=======================================================
module SC_RegRANDOM #(parameter RegRANDOM_DATAWIDTH=8)(
	//////////// OUTPUTS //////////
	SC_RegRANDOMOutRightBUS, // Los 4 bits de más a la derecha
	SC_RegRANDOMOutLeftBUS, // Los 4 bits de más a la Izquierda
	//////////// INPUTS //////////
	SC_RegRANDOM_CLOCK_50,
	SC_RegRANDOM_RESET_InHigh,
	SC_RegRANDOM_clear_InLow
);
//=======================================================
//  PARAMETER declarations
//=======================================================
//parameter RegRANDOM_DATAWIDTH = 8;
//=======================================================
//  PORT declarations
//=======================================================
output	[7:0]	SC_RegRANDOMOutRightBUS;
output	[7:0]	SC_RegRANDOMOutLeftBUS;
input		SC_RegRANDOM_CLOCK_50;
input		SC_RegRANDOM_RESET_InHigh;
input		SC_RegRANDOM_clear_InLow;

//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [RegRANDOM_DATAWIDTH-1:0] RegRANDOM_Register;
reg [RegRANDOM_DATAWIDTH-1:0] RegRANDOM_Signal;
wire MVB_Out;
//=======================================================
//  Structural coding
//=======================================================
always @(*)
//INPUT LOGIC: COMBINATIONAL
	begin
		RegRANDOM_Signal = {RegRANDOM_Register[6:0], MVB_Out};
	end	
//STATE REGISTER: SEQUENTIAL
always @(posedge SC_RegRANDOM_CLOCK_50, posedge SC_RegRANDOM_RESET_InHigh)
begin
	if (SC_RegRANDOM_RESET_InHigh == 1'b1)
		RegRANDOM_Register <= 8'b00111100;
	else
		RegRANDOM_Register <= RegRANDOM_Signal;
end
//=======================================================
//  Outputs
//=======================================================
//OUTPUT LOGIC: COMBINATIONAL
assign MVB_Out = RegRANDOM_Register[1] ^ RegRANDOM_Register[2];
assign SC_RegRANDOMOutRightBUS = {4'b0000, RegRANDOM_Register[3:0]};
assign SC_RegRANDOMOutLeftBUS = {4'b0000, RegRANDOM_Register[7:4]};

endmodule

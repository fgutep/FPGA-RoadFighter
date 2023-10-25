//=======================================================
//   MODULE Definition
//=======================================================
module SC_COUNTER #(parameter COUNTER_DATAWITH=8)(
//////////////////OUTPUTS///////////////
  SC_COUNTER_data_OutBUS,
//////////////////INPUTS////////////////
  SC_COUNTER_CLOCK_50,
  SC_COUNTER_RESET_InHigh,
  SC_COUNTER_count_InLow
 );
//=======================================================
//  PORT declarations
//=======================================================
output	[COUNTER_DATAWIDTH-1:0] SC_COUNTER_data_OutBUS;
input   SC_COUNTER_CLOCK_50;
input   SC_COUNTER_RESET_InHigh;
input   SC_COUNTER_count_InLow
//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [COUNTER_DATAWIDTH-1:0] COUNTER_Register;
reg [COUNTER_DATAWIDTH-1:0] COUNTER_Signal;
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always @(*)
begin
	if (SC_COUNTER_count_InLow == 1'b0)
		COUNTER_Signal = COUNTER_Register + 1'b1;
	else
		COUNTER_Signal = COUNTER_Register;
		
	end
//STATE REGISTER: SEQUENTIAL
always @(posedge SC_COUNTER_CLOCK_50, posedge SC_COUNTER_RESET_InHigh)
begin 
	if (SC_COUNTER_RESET_InHigh == 1'b1)
		COUNTER_Register <= 0;
	else
		COUNTER_Register <= COUNTER_Signal;
end
//=======================================================
// Outputs
//=======================================================
//OUTPUT LOGIC: COMBINATIONAL
assign SC_COUNTER_data_OutBUS = COUNTER_Register;

endmodule
  
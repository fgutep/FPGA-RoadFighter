/*######################################################################
//#	G0B1T: HDL EXAMPLES. 2018.
//######################################################################
//# Copyright (C) 2018. F.E.Segura-Quijano (FES) fsegura@uniandes.edu.co
//# 
//# This program is free software: you can redistribute it and/or modify
//# it under the terms of the GNU General Public License as published by
//# the Free Software Foundation, version 3 of the License.
//#
//# This program is distributed in the hope that it will be useful,
//# but WITHOUT ANY WARRANTY; without even the implied warranty of
//# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//# GNU General Public License for more details.
//#
//# You should have received a copy of the GNU General Public License
//# along with this program.  If not, see <http://www.gnu.org/licenses/>
//####################################################################*/
//=======================================================
//  MODULE Definition
//=======================================================
module SC_RegBACKGTYPE #(parameter RegBACKGTYPE_DATAWIDTH=8, parameter DATA_FIXED_INITREGBACKG=8'b00000000)(
	//////////// OUTPUTS //////////
	SC_RegBACKGTYPE_data_OutBUS,
	//////////// INPUTS //////////
	SC_RegBACKGTYPE_CLOCK_50,
	SC_RegBACKGTYPE_RESET_InHigh,
	SC_RegBACKGTYPE_clear_InLow, 
	SC_RegBACKGTYPE_load_InLow, 
	SC_RegBACKGTYPE_shiftselection_In,
	SC_RegBACKGTYPE_data_InBUS
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output		[RegBACKGTYPE_DATAWIDTH-1:0]	SC_RegBACKGTYPE_data_OutBUS;
input		SC_RegBACKGTYPE_CLOCK_50;
input		SC_RegBACKGTYPE_RESET_InHigh;
input		SC_RegBACKGTYPE_clear_InLow;
input		SC_RegBACKGTYPE_load_InLow;	
input		[1:0] SC_RegBACKGTYPE_shiftselection_In;
input		[RegBACKGTYPE_DATAWIDTH-1:0]	SC_RegBACKGTYPE_data_InBUS;

//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [RegBACKGTYPE_DATAWIDTH-1:0] RegBACKGTYPE_Register;
reg [RegBACKGTYPE_DATAWIDTH-1:0] RegBACKGTYPE_Signal;
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always @(*)
begin
	if (SC_RegBACKGTYPE_clear_InLow == 1'b0)
		RegBACKGTYPE_Signal = DATA_FIXED_INITREGBACKG;
	else if (SC_RegBACKGTYPE_load_InLow == 1'b0)
		RegBACKGTYPE_Signal = SC_RegBACKGTYPE_data_InBUS;
	else if (SC_RegBACKGTYPE_shiftselection_In == 2'b01)
		RegBACKGTYPE_Signal = {RegBACKGTYPE_Register[RegBACKGTYPE_DATAWIDTH-2:0],RegBACKGTYPE_Register[RegBACKGTYPE_DATAWIDTH-1]};
	else if (SC_RegBACKGTYPE_shiftselection_In== 2'b10)
		RegBACKGTYPE_Signal = {RegBACKGTYPE_Register[0],RegBACKGTYPE_Register[RegBACKGTYPE_DATAWIDTH-1:1]};
	else
		RegBACKGTYPE_Signal = RegBACKGTYPE_Register;
	end	
//STATE REGISTER: SEQUENTIAL
always @(posedge SC_RegBACKGTYPE_CLOCK_50, posedge SC_RegBACKGTYPE_RESET_InHigh)
begin
	if (SC_RegBACKGTYPE_RESET_InHigh == 1'b1)
		RegBACKGTYPE_Register <= 0;
	else
		RegBACKGTYPE_Register <= RegBACKGTYPE_Signal;
end
//=======================================================
//  Outputs
//=======================================================
//OUTPUT LOGIC: COMBINATIONAL
assign SC_RegBACKGTYPE_data_OutBUS = RegBACKGTYPE_Register;

endmodule

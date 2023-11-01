// 8-bit RandReg
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
module SC_RegRANDOM #(parameter RegRANDOM_DATAWIDTH=8)(
	//////////// OUTPUTS //////////
	SC_RegRANDOM_data_OutBUS,
	//////////// INPUTS //////////
	SC_RegRANDOM_CLOCK_50,
	SC_RegRANDOM_RESET_InHigh
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output		[RegRANDOML_DATAWIDTH-1:0]	SC_RegRANDOML_data_OutBUS;
input		SC_RegRANDOM_CLOCK_50;
input		SC_RegRANDOM_RESET_InHigh;

//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [RegRANDOM_DATAWIDTH-1:0] RegRANDOM_Register;
reg [RegRANDOM_DATAWIDTH-1:0] RegRANDOM_Signal;
wire RandFeedback;
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always @(*)
begin
	RegRand_Signal = {RegRANDOM_Register[6:0], RandFeedback};
end

always @(posedge SC_RegRANDOM_CLOCK_50, posedge SC_RegRANDOM_RESET_InHigh)
begin
	if (SC_RegRANDOM_RESET_InHigh == 1'b1)
	RegRANDOM_Register <= 8'b10011001;
	else
	RegRANDOM_Register <= RegRand_Signal;
end
//=======================================================
//  Outputs
//=======================================================
//OUTPUT LOGIC: COMBINATIONAL
assign RandFeedback = RegRANDOM_Register[6] ^ RegRANDOM_Register[5] ^ RegRANDOM_Register[3] ^ RegRANDOM_Register[0];
assign RegRANDOM_data_OutBUS = RegRANDOM_Register;
endmodule 
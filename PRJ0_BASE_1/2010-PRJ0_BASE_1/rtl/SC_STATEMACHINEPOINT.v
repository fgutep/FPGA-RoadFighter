///*######################################################################
//#	G0B1T: HDL EXAMPLES. 2024.
//######################################################################
//# Copyright (C) 2024. F.E.Segura-Quijano (FES) fsegura@uniandes.edu.co
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
module SC_STATEMACHINEPOINT (
	//////////// OUTPUTS //////////
	SC_STATEMACHINEPOINT_clear_OutLow,
	SC_STATEMACHINEPOINT_load_OutLow,
	SC_STATEMACHINEPOINT_shiftselection_Out,

	//////////// INPUTS //////////
	SC_STATEMACHINEPOINT_CLOCK_50,
	SC_STATEMACHINEPOINT_RESET_InHigh,
	SC_STATEMACHINEPOINT_startButton_InLow,
	SC_STATEMACHINEPOINT_leftButton_InLow,
	SC_STATEMACHINEPOINT_rightButton_InLow,
	SC_STATEMACHINEPOINT_sidecomparator_InLow
);	
//=======================================================
//  PARAMETER declarations
//=======================================================
// states declaration
localparam STATE_RESET_0									= 0;
localparam STATE_START_0									= 1;
localparam STATE_CHECK_0									= 2;
localparam STATE_INIT_0											= 3;
localparam STATE_INIT_1											= 4;
localparam STATE_LEFT_0										= 5; 
localparam STATE_RIGHT_0										= 6;
localparam STATE_CHECK_1									= 7;
//=======================================================
//  PORT declarations
//=======================================================
output reg		SC_STATEMACHINEPOINT_clear_OutLow;
output reg		SC_STATEMACHINEPOINT_load_OutLow;
output reg		[1:0] SC_STATEMACHINEPOINT_shiftselection_Out;
input					SC_STATEMACHINEPOINT_CLOCK_50;
input 				SC_STATEMACHINEPOINT_RESET_InHigh;
input					SC_STATEMACHINEPOINT_startButton_InLow;
input					SC_STATEMACHINEPOINT_leftButton_InLow;
input					SC_STATEMACHINEPOINT_rightButton_InLow;
input					SC_STATEMACHINEPOINT_sidecomparator_InLow;
//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [3:0] STATE_Register;
reg [3:0] STATE_Signal;
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
// NEXT STATE LOGIC : COMBINATIONAL
always @(*)
begin
	case (STATE_Register)
		STATE_RESET_0: STATE_Signal = STATE_START_0;
		STATE_START_0: STATE_Signal = STATE_CHECK_0;
		STATE_CHECK_0: if (SC_STATEMACHINEPOINT_startButton_InLow == 1'b0) STATE_Signal = STATE_INIT_0;
						else if (SC_STATEMACHINEPOINT_leftButton_InLow == 1'b0 & (SC_STATEMACHINEPOINT_sidecomparator_InLow == 1'b1)) STATE_Signal = STATE_LEFT_0;
						else if (SC_STATEMACHINEPOINT_rightButton_InLow == 1'b0 & (SC_STATEMACHINEPOINT_sidecomparator_InLow == 1'b1)) STATE_Signal = STATE_RIGHT_0;
						else STATE_Signal = STATE_CHECK_0;
		STATE_INIT_0: 	STATE_Signal = STATE_INIT_1;
		STATE_INIT_1: 	STATE_Signal = STATE_CHECK_1;
		STATE_LEFT_0:  	STATE_Signal = STATE_CHECK_1;
		STATE_RIGHT_0:  STATE_Signal = STATE_CHECK_1;

		STATE_CHECK_1: if (SC_STATEMACHINEPOINT_startButton_InLow == 1'b0) STATE_Signal = STATE_CHECK_1;
						else if (SC_STATEMACHINEPOINT_leftButton_InLow == 1'b0) STATE_Signal = STATE_CHECK_1;
						else if (SC_STATEMACHINEPOINT_rightButton_InLow == 1'b0) STATE_Signal = STATE_CHECK_1;
						else STATE_Signal = STATE_CHECK_0;

		default : 		STATE_Signal = STATE_CHECK_0;
	endcase
end

// STATE REGISTER : SEQUENTIAL
always @ ( posedge SC_STATEMACHINEPOINT_CLOCK_50 , posedge SC_STATEMACHINEPOINT_RESET_InHigh)
begin
	if (SC_STATEMACHINEPOINT_RESET_InHigh == 1'b1)
		STATE_Register <= STATE_RESET_0;
	else
		STATE_Register <= STATE_Signal;
end
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL
always @ (*)
begin
	case (STATE_Register)
//=========================================================
// STATE_RESET
//=========================================================
	STATE_RESET_0 :	
		begin
			SC_STATEMACHINEPOINT_clear_OutLow = 1'b1;
			SC_STATEMACHINEPOINT_load_OutLow = 1'b1;
			SC_STATEMACHINEPOINT_shiftselection_Out  = 2'b11; 
		end
//=========================================================
// STATE_START
//=========================================================
	STATE_START_0 :	
		begin
			SC_STATEMACHINEPOINT_clear_OutLow = 1'b1;
			SC_STATEMACHINEPOINT_load_OutLow = 1'b1;
			SC_STATEMACHINEPOINT_shiftselection_Out  = 2'b11; 
		end
//=========================================================
// STATE_CHECK
//=========================================================
	STATE_CHECK_0 :
		begin
			SC_STATEMACHINEPOINT_clear_OutLow = 1'b1;
			SC_STATEMACHINEPOINT_load_OutLow = 1'b1;
			SC_STATEMACHINEPOINT_shiftselection_Out  = 2'b11; 
		end
//=========================================================
// STATE_CHECK
//=========================================================
	STATE_CHECK_1 :
		begin
			SC_STATEMACHINEPOINT_clear_OutLow = 1'b1;
			SC_STATEMACHINEPOINT_load_OutLow = 1'b1;
			SC_STATEMACHINEPOINT_shiftselection_Out  = 2'b11; 
		end
//=========================================================
// STATE_INIT_0
//=========================================================
	STATE_INIT_0 :	
		begin
			SC_STATEMACHINEPOINT_clear_OutLow = 1'b0;
			SC_STATEMACHINEPOINT_load_OutLow = 1'b1;
			SC_STATEMACHINEPOINT_shiftselection_Out  = 2'b11; 
		end
//=========================================================
// STATE_INIT_1
//=========================================================
	STATE_INIT_1 :	
		begin
			SC_STATEMACHINEPOINT_clear_OutLow = 1'b1;
			SC_STATEMACHINEPOINT_load_OutLow = 1'b0;
			SC_STATEMACHINEPOINT_shiftselection_Out  = 2'b11; 
		end
//=========================================================
// STATE_LEFT_0
//=========================================================
	STATE_LEFT_0 :	
		begin
			SC_STATEMACHINEPOINT_clear_OutLow = 1'b1;
			SC_STATEMACHINEPOINT_load_OutLow = 1'b1;
			SC_STATEMACHINEPOINT_shiftselection_Out  = 2'b01; 
		end
//=========================================================
// STATE_RIGHT_0
//=========================================================
	STATE_RIGHT_0 :	
		begin
			SC_STATEMACHINEPOINT_clear_OutLow = 1'b1;
			SC_STATEMACHINEPOINT_load_OutLow = 1'b1;
			SC_STATEMACHINEPOINT_shiftselection_Out  = 2'b10; 
		end

//=========================================================
// DEFAULT
//=========================================================
	default :
		begin
			SC_STATEMACHINEPOINT_clear_OutLow = 1'b1;
			SC_STATEMACHINEPOINT_load_OutLow = 1'b1;
			SC_STATEMACHINEPOINT_shiftselection_Out  = 2'b11; 
		end
	endcase
end
endmodule

//*######################################################################
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
module SC_STATEMACHINEBACKG (
    //////////// OUTPUTS //////////
    SC_STATEMACHINEBACKG_clear_OutLow,
    SC_STATEMACHINEBACKG_load_OutLow,
    SC_STATEMACHINEBACKG_upcount_out,
    //////////// INPUTS //////////
    SC_STATEMACHINEBACKG_CLOCK_50,
    SC_STATEMACHINEBACKG_RESET_InHigh,
    SC_STATEMACHINEBACKG_startButton_InLow,
    SC_STATEMACHINEBACKG_T0_InLow
);

//=======================================================
//  PARAMETER declarations
//=======================================================
// states declaration
localparam STATE_RESET_0      = 0;
localparam STATE_START_0      = 1;
localparam STATE_CHECK_START  = 2;
localparam STATE_CHECK_LOAD  	= 3;
localparam STATE_SENDLOAD     = 4;

//=======================================================
//  PORT declarations
//=======================================================
output reg      SC_STATEMACHINEBACKG_clear_OutLow;
output reg      SC_STATEMACHINEBACKG_load_OutLow;
output reg      SC_STATEMACHINEBACKG_upcount_out;
input           SC_STATEMACHINEBACKG_CLOCK_50;
input           SC_STATEMACHINEBACKG_RESET_InHigh;
input           SC_STATEMACHINEBACKG_startButton_InLow;
input           SC_STATEMACHINEBACKG_T0_InLow;

//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [3:0] STATE_Register;
reg [3:0] STATE_Signal;

//=======================================================
//  Structural coding
//=======================================================
// INPUT LOGIC: COMBINATIONAL
// NEXT STATE LOGIC: COMBINATIONAL
always @(*)
begin
    case (STATE_Register)
        STATE_RESET_0: STATE_Signal = STATE_START_0;
        STATE_START_0: STATE_Signal = STATE_CHECK_START;
        STATE_CHECK_START: if (SC_STATEMACHINEBACKG_startButton_InLow == 1'b0) 
                            STATE_Signal = STATE_CHECK_LOAD;
                        else STATE_Signal = STATE_CHECK_START;

        STATE_CHECK_LOAD: if (SC_STATEMACHINEBACKG_T0_InLow == 1'b0) 
                            STATE_Signal = STATE_SENDLOAD;
                        else STATE_Signal = STATE_CHECK_LOAD;

        default : STATE_Signal = STATE_CHECK_LOAD;  
    endcase
end

// STATE REGISTER: SEQUENTIAL
always @ (posedge SC_STATEMACHINEBACKG_CLOCK_50, posedge SC_STATEMACHINEBACKG_RESET_InHigh)
begin
    if (SC_STATEMACHINEBACKG_RESET_InHigh == 1'b1)
        STATE_Register <= STATE_RESET_0;
    else
        STATE_Register <= STATE_Signal;
end

//=======================================================
// Outputs
//=======================================================
// OUTPUT LOGIC: COMBINATIONAL
always @ (*)
begin
    case (STATE_Register)
        // STATE_RESET
        STATE_RESET_0 :    
            begin
                SC_STATEMACHINEBACKG_clear_OutLow = 1'b0;
                SC_STATEMACHINEBACKG_load_OutLow = 1'b1;
                SC_STATEMACHINEBACKG_upcount_out = 1'b1;
            end

        // STATE_START
        STATE_START_0 :    
            begin
                SC_STATEMACHINEBACKG_clear_OutLow = 1'b1;
                SC_STATEMACHINEBACKG_load_OutLow = 1'b1;
                SC_STATEMACHINEBACKG_upcount_out = 1'b1;
            end

        // STATE_CHECK_START
        STATE_CHECK_START :
            begin
                SC_STATEMACHINEBACKG_clear_OutLow = 1'b1;
                SC_STATEMACHINEBACKG_load_OutLow = 1'b1;
                SC_STATEMACHINEBACKG_upcount_out = 1'b1;
            end

        // STATE_CHECK_LOAD
        STATE_CHECK_LOAD :
            begin
                SC_STATEMACHINEBACKG_clear_OutLow = 1'b1;
                SC_STATEMACHINEBACKG_load_OutLow = 1'b1;
                SC_STATEMACHINEBACKG_upcount_out = 1'b1;
            end

        // STATE_SENDLOAD
        STATE_SENDLOAD :
            begin
                SC_STATEMACHINEBACKG_clear_OutLow = 1'b1;
                SC_STATEMACHINEBACKG_load_OutLow = 1'b0;
                SC_STATEMACHINEBACKG_upcount_out = 1'b1;
            end

        // Default case added to handle unexpected conditions
        default :
            begin
                SC_STATEMACHINEBACKG_clear_OutLow = 1'b1;
                SC_STATEMACHINEBACKG_load_OutLow = 1'b1;
                SC_STATEMACHINEBACKG_upcount_out = 1'b1;
            end
    endcase
end

endmodule

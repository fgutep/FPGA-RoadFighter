  /*######################################################################
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
module BB_SYSTEM (
//////////// OUTPUTS //////////
	BB_SYSTEM_display_OutBUS,
	BB_SYSTEM_max7219DIN_Out,
	BB_SYSTEM_max7219NCS_Out,
	BB_SYSTEM_max7219CLK_Out,

//////////// INPUTS //////////
	BB_SYSTEM_CLOCK_50,
	BB_SYSTEM_RESET_InHigh,
	BB_SYSTEM_startButton_InLow, 
	BB_SYSTEM_leftButton_InLow,
	BB_SYSTEM_rightButton_InLow,
	BB_SYSTEM_leftButton_InLow1,	//[NOTA] Se debe asignar el pin
	BB_SYSTEM_rightButton_InLow1	//[NOTA] Se debe asignar el pin
);
//=======================================================
//  PARAMETER declarations
//=======================================================
 parameter DATAWIDTH_BUS = 8; //DEBUG
 parameter PRESCALER_DATAWIDTH = 23;
 parameter DISPLAY_DATAWIDTH = 12;

 
 //Background
 
 parameter DATA_FIXED_INITREGBACKG_7 = 4'b0000;
 parameter DATA_FIXED_INITREGBACKG_6 = 4'b0000;
 parameter DATA_FIXED_INITREGBACKG_5 = 4'b0000;
 parameter DATA_FIXED_INITREGBACKG_4 = 4'b0000;
 parameter DATA_FIXED_INITREGBACKG_3 = 4'b0000;
 parameter DATA_FIXED_INITREGBACKG_2 = 4'b0000;
 parameter DATA_FIXED_INITREGBACKG_1 = 4'b0000;
 parameter DATA_FIXED_INITREGBACKG_0 = 4'b0000;
  
 parameter DATA_FIXED_INITREGPOINTS = 4'b0010;
//=======================================================
//  PORT declarations
//=======================================================
output		[DISPLAY_DATAWIDTH-1:0] BB_SYSTEM_display_OutBUS;

output		BB_SYSTEM_max7219DIN_Out;
output		BB_SYSTEM_max7219NCS_Out;
output		BB_SYSTEM_max7219CLK_Out;

input		BB_SYSTEM_CLOCK_50;
input		BB_SYSTEM_RESET_InHigh;
input		BB_SYSTEM_startButton_InLow;
input		BB_SYSTEM_leftButton_InLow;
input		BB_SYSTEM_rightButton_InLow;
input		BB_SYSTEM_leftButton_InLow1;
input		BB_SYSTEM_rightButton_InLow1;
//=======================================================
//  REG/WIRE declarations
//=======================================================
// BUTTONs - Player 0
wire 	BB_SYSTEM_startButton_InLow_cwire;
wire 	BB_SYSTEM_leftButton_InLow_cwire;
wire 	BB_SYSTEM_rightButton_InLow_cwire;

// BUTTONs - Player 1
wire 	BB_SYSTEM_leftButton_InLow_cwire1;
wire 	BB_SYSTEM_rightButton_InLow_cwire1;

//POINT - Statemachine Point 0
wire	STATEMACHINEPOINT_clear_cwire;
wire	STATEMACHINEPOINT_load_cwire;
wire	[1:0] STATEMACHINEPOINT_shiftselection_cwire;
wire 	[3:0] Wire_Out_Shift_P0;
//POINT - Statemachine Point 1
wire	STATEMACHINEPOINT_clear_cwire1;
wire	STATEMACHINEPOINT_load_cwire1;
wire	[1:0] STATEMACHINEPOINT_shiftselection_cwire1;
wire 	[3:0] Wire_Out_Shift_P1;

// POINT - Common Wires
wire [DATAWIDTH_BUS-1:0] RegPOINTTYPE_2_POINTMATRIX_data0_Out;

//SIDE COMPARATOR
wire SIDECOMPARATOR_2_STATEMACHINEBACKG_side_cwire;

// GAME VISUALIZATION
wire [DATAWIDTH_BUS-1:0] regGAME_data7_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data6_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data5_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data4_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data3_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data2_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data1_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data0_wire;

// Wires for Background State-Machine - Player u0
wire [PRESCALER_DATAWIDTH-1:0] upCOUNTER_data_BUS_wire;
wire SPEEDCOMPARATOR_2_STATEMACHINEBACKG_T0_cwire;
wire [22:0] SPEEDCOUNTER_2_SPEEDCOMPARATOR;
wire STATEMACHINEBACKG_clear_cwire;
wire STATEMACHINEBACKG_load_cwire;
wire [1:0] STATEMACHINEBACKG_shiftselection_cwire;
wire STATEMACHINEBACKG_upcount_cwire;

// Wires for Background State-Machine - Player u1
wire [PRESCALER_DATAWIDTH-1:0] upCOUNTER_data_BUS_wire1;
wire SPEEDCOMPARATOR_2_STATEMACHINEBACKG_T0_cwire1;
wire [22:0] SPEEDCOUNTER_2_SPEEDCOMPARATOR1;
wire STATEMACHINEBACKG_clear_cwire1;
wire STATEMACHINEBACKG_load_cwire1;
wire [1:0] STATEMACHINEBACKG_shiftselection_cwire1;
wire STATEMACHINEBACKG_upcount_cwire1;

// Wires for Jugabilidad - Player u0
wire P0Jugabilidad_load_2_BgRegs;
wire [3:0]RandP0_out_to_concat;
wire 	[7:0] RandP0_2_Playability;

// Wires for Jugabilidad - Player u0
wire P1Jugabilidad_load_2_BgRegs;
wire [3:0]RandP1_out_to_concat;
wire 	[7:0] RandP1_2_Playability;

// Random Register to top-most register
wire [7:0] RandRegL_2_BgReg17; //Izquierda
wire [7:0] RandRegR_2_BgReg7; // Derecha

// Conections between registers - Player 0
wire [7:0] BgReg7_2_BgReg6;
wire [7:0] BgReg6_2_BgReg5;
wire [7:0] BgReg5_2_BgReg4;
wire [7:0] BgReg4_2_BgReg3;
wire [7:0] BgReg3_2_BgReg2;
wire [7:0] BgReg2_2_BgReg1;
wire [7:0] BgReg1_2_BgReg0;

// Conections between registers - Player 1
wire [7:0] BgReg17_2_BgReg16;
wire [7:0] BgReg16_2_BgReg15;
wire [7:0] BgReg15_2_BgReg14;
wire [7:0] BgReg14_2_BgReg13;
wire [7:0] BgReg13_2_BgReg12;
wire [7:0] BgReg12_2_BgReg11;
wire [7:0] BgReg11_2_BgReg10;

// Background Connections of player 0.
wire [DATAWIDTH_BUS-1:0] Player0_Backg7;
wire [DATAWIDTH_BUS-1:0] Player0_Backg6;
wire [DATAWIDTH_BUS-1:0] Player0_Backg5;
wire [DATAWIDTH_BUS-1:0] Player0_Backg4;
wire [DATAWIDTH_BUS-1:0] Player0_Backg3;
wire [DATAWIDTH_BUS-1:0] Player0_Backg2;
wire [DATAWIDTH_BUS-1:0] Player0_Backg1;
wire [DATAWIDTH_BUS-1:0] Player0_Backg0;

// Background Connections of player 1.
wire [DATAWIDTH_BUS-1:0] Player1_Backg17;
wire [DATAWIDTH_BUS-1:0] Player1_Backg16;
wire [DATAWIDTH_BUS-1:0] Player1_Backg15;
wire [DATAWIDTH_BUS-1:0] Player1_Backg14;
wire [DATAWIDTH_BUS-1:0] Player1_Backg13;
wire [DATAWIDTH_BUS-1:0] Player1_Backg12;
wire [DATAWIDTH_BUS-1:0] Player1_Backg11;
wire [DATAWIDTH_BUS-1:0] Player1_Backg10;

// Background Conections to LEDMATRIX handler.
wire [DATAWIDTH_BUS-1:0] RegBACKGTYPE_2_BACKGMATRIX_data7_Out;
wire [DATAWIDTH_BUS-1:0] RegBACKGTYPE_2_BACKGMATRIX_data6_Out;
wire [DATAWIDTH_BUS-1:0] RegBACKGTYPE_2_BACKGMATRIX_data5_Out;
wire [DATAWIDTH_BUS-1:0] RegBACKGTYPE_2_BACKGMATRIX_data4_Out;
wire [DATAWIDTH_BUS-1:0] RegBACKGTYPE_2_BACKGMATRIX_data3_Out;
wire [DATAWIDTH_BUS-1:0] RegBACKGTYPE_2_BACKGMATRIX_data2_Out;
wire [DATAWIDTH_BUS-1:0] RegBACKGTYPE_2_BACKGMATRIX_data1_Out;
wire [DATAWIDTH_BUS-1:0] RegBACKGTYPE_2_BACKGMATRIX_data0_Out;

// To Matrix
wire 	[7:0] data_max;
wire 	[2:0] add;
wire [DATAWIDTH_BUS-1:0] upCOUNTER_2_BIN2BCD1_data_BUS_wire;
wire [DISPLAY_DATAWIDTH-1:0] BIN2BCD1_2_SEVENSEG1_data_BUS_wire;

//=======================================================
//  Structural coding
//=======================================================

//######################################################################
//#	INPUTS
//######################################################################
SC_DEBOUNCE1 SC_DEBOUNCE1_u0 (
// port map - connection between master ports and signals/registers   
	.SC_DEBOUNCE1_button_Out(BB_SYSTEM_startButton_InLow_cwire),
	.SC_DEBOUNCE1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_DEBOUNCE1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_DEBOUNCE1_button_In(~BB_SYSTEM_startButton_InLow)
);
// PUNTO DELA IZQUIERDA 

SC_DEBOUNCE1 SC_DEBOUNCE1_u1 (
// port map - connection between master ports and signals/registers   
	.SC_DEBOUNCE1_button_Out(BB_SYSTEM_leftButton_InLow_cwire),
	.SC_DEBOUNCE1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_DEBOUNCE1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_DEBOUNCE1_button_In(~BB_SYSTEM_leftButton_InLow)
);
SC_DEBOUNCE1 SC_DEBOUNCE1_u2 (
// port map - connection between master ports and signals/registers   
	.SC_DEBOUNCE1_button_Out(BB_SYSTEM_rightButton_InLow_cwire),
	.SC_DEBOUNCE1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_DEBOUNCE1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_DEBOUNCE1_button_In(~BB_SYSTEM_rightButton_InLow)
);

//Punto de la derecha
SC_DEBOUNCE1 SC_DEBOUNCE1_u3 (
// port map - connection between master ports and signals/registers   
	.SC_DEBOUNCE1_button_Out(BB_SYSTEM_leftButton_InLow_cwire1),
	.SC_DEBOUNCE1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_DEBOUNCE1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_DEBOUNCE1_button_In(~BB_SYSTEM_leftButton_InLow1)
);
SC_DEBOUNCE1 SC_DEBOUNCE1_u4 (
// port map - connection between master ports and signals/registers   
	.SC_DEBOUNCE1_button_Out(BB_SYSTEM_rightButton_InLow_cwire1),
	.SC_DEBOUNCE1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_DEBOUNCE1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_DEBOUNCE1_button_In(~BB_SYSTEM_rightButton_InLow1)
);
//######################################################################
//#	POINT - Jugador Derecha [U0]
//######################################################################
SC_RegSHIFTER #(.RegSHIFTER_DATAWIDTH(DATAWIDTH_BUS)) 
SC_RegSHIFTER_u0 (
// port map - connection between master ports and signals/registers   
	.SC_RegSHIFTER_data_OutBUS(Wire_Out_Shift_P0),
	.SC_RegSHIFTER_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegSHIFTER_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegSHIFTER_clear_InLow(STATEMACHINEPOINT_clear_cwire),
	.SC_RegSHIFTER_load_InLow(STATEMACHINEPOINT_load_cwire),
	.SC_RegSHIFTER_shiftselection_In(STATEMACHINEPOINT_shiftselection_cwire),
	.SC_RegSHIFTER_data_InBUS(DATA_FIXED_INITREGPOINTS)
);

SC_STATEMACHINEPOINT SC_STATEMACHINEPOINT_u0 (
// port map - connection between master ports and signals/registers   
	.SC_STATEMACHINEPOINT_clear_OutLow(STATEMACHINEPOINT_clear_cwire), 
	.SC_STATEMACHINEPOINT_load_OutLow(STATEMACHINEPOINT_load_cwire), 
	.SC_STATEMACHINEPOINT_shiftselection_Out(STATEMACHINEPOINT_shiftselection_cwire),
	.SC_STATEMACHINEPOINT_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_STATEMACHINEPOINT_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_STATEMACHINEPOINT_startButton_InLow(BB_SYSTEM_startButton_InLow_cwire), 
	.SC_STATEMACHINEPOINT_leftButton_InLow(BB_SYSTEM_leftButton_InLow_cwire), 
	.SC_STATEMACHINEPOINT_rightButton_InLow(BB_SYSTEM_rightButton_InLow_cwire)
); 

//######################################################################
//#	POINT - Jugador Izquierda [U1]
//######################################################################
SC_RegSHIFTER #(.RegSHIFTER_DATAWIDTH(DATAWIDTH_BUS)) 
SC_RegSHIFTER_u1 (
// port map - connection between master ports and signals/registers   
	.SC_RegSHIFTER_data_OutBUS(Wire_Out_Shift_P1),//[Acá tocará hacer el truco del RegConcat]
	.SC_RegSHIFTER_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegSHIFTER_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegSHIFTER_clear_InLow(STATEMACHINEPOINT_clear_cwire1),
	.SC_RegSHIFTER_load_InLow(STATEMACHINEPOINT_load_cwire1),
	.SC_RegSHIFTER_shiftselection_In(STATEMACHINEPOINT_shiftselection_cwire1),
	.SC_RegSHIFTER_data_InBUS(DATA_FIXED_INITREGPOINTS)
);

SC_STATEMACHINEPOINT SC_STATEMACHINEPOINT_u1 (
// port map - connection between master ports and signals/registers   
	.SC_STATEMACHINEPOINT_clear_OutLow(STATEMACHINEPOINT_clear_cwire1), 
	.SC_STATEMACHINEPOINT_load_OutLow(STATEMACHINEPOINT_load_cwire1), 
	.SC_STATEMACHINEPOINT_shiftselection_Out(STATEMACHINEPOINT_shiftselection_cwire1),
	.SC_STATEMACHINEPOINT_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_STATEMACHINEPOINT_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_STATEMACHINEPOINT_startButton_InLow(BB_SYSTEM_startButton_InLow_cwire), 
	.SC_STATEMACHINEPOINT_leftButton_InLow(BB_SYSTEM_leftButton_InLow_cwire1), 
	.SC_STATEMACHINEPOINT_rightButton_InLow(BB_SYSTEM_rightButton_InLow_cwire1)
); 
//######################################################################
//#	POINTS - Truquitos ;)
//######################################################################
// Tenemos que coger la salida del regShifteru0 , la del regShifterU1 y concateneralas para display
assign RegPOINTTYPE_2_POINTMATRIX_data0_Out = {Wire_Out_Shift_P1[3:0], Wire_Out_Shift_P0[3:0]};


//######################################################################
//#	BACKGROUND VISUALIZATION - Commom Random
//######################################################################

SC_RegRANDOM #(.RegRANDOM_DATAWIDTH(DATAWIDTH_BUS)) SC_RegRANDOM_u0 (
    // port map - connection between master ports and signals/registers   
    .SC_RegRANDOMOutLeftBUS(RandP1_2_Playability),
	 .SC_RegRANDOMOutRightBUS(RandP0_2_Playability),
    .SC_RegRANDOM_CLOCK_50(BB_SYSTEM_CLOCK_50),
    .SC_RegRANDOM_RESET_InHigh(BB_SYSTEM_RESET_InHigh)
);
//######################################################################
//#	BACKGROUND VISUALIZATION - Player 0 (Derecha)
//######################################################################

SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS)) SC_RegBACKGTYPE_u7 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS_2DISP(Player0_Backg7),
	.SC_RegBACKGTYPE_data_OutBUS_2REG(BgReg7_2_BgReg6),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(P0ilidad_load_2_BgRegs), // DEBUG STATEMACHINEBACKG_load_cwire  [PARA TODOS]
	.SC_RegBACKGTYPE_data_InBUS(RandRegR_2_BgReg7) // Tomar 4 bits del bus de 8 de RegRandom
);
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS)) SC_RegBACKGTYPE_u6 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS_2DISP(Player0_Backg6),
	.SC_RegBACKGTYPE_data_OutBUS_2REG(BgReg6_2_BgReg5),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(P0Jugabilidad_load_2_BgRegs), 
	.SC_RegBACKGTYPE_data_InBUS(BgReg7_2_BgReg6) // DEBUG BgReg7_2_BgReg6
); 
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS)) SC_RegBACKGTYPE_u5 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS_2DISP(Player0_Backg5),
	.SC_RegBACKGTYPE_data_OutBUS_2REG(BgReg5_2_BgReg4),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(P0Jugabilidad_load_2_BgRegs),
	.SC_RegBACKGTYPE_data_InBUS(BgReg6_2_BgReg5)
);
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS)) SC_RegBACKGTYPE_u4 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS_2DISP(Player0_Backg4),
	.SC_RegBACKGTYPE_data_OutBUS_2REG(BgReg4_2_BgReg3),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(P0Jugabilidad_load_2_BgRegs),
	.SC_RegBACKGTYPE_data_InBUS(BgReg5_2_BgReg4)
);
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS)) SC_RegBACKGTYPE_u3 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS_2DISP(Player0_Backg3),
	.SC_RegBACKGTYPE_data_OutBUS_2REG(BgReg3_2_BgReg2),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(P0Jugabilidad_load_2_BgRegs),
	.SC_RegBACKGTYPE_data_InBUS(BgReg4_2_BgReg3)
);
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS)) SC_RegBACKGTYPE_u2 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS_2DISP(Player0_Backg2),
	.SC_RegBACKGTYPE_data_OutBUS_2REG(BgReg2_2_BgReg1),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(P0Jugabilidad_load_2_BgRegs),
	.SC_RegBACKGTYPE_data_InBUS(BgReg3_2_BgReg2)
);
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS)) SC_RegBACKGTYPE_u1 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS_2DISP(Player0_Backg1),
	.SC_RegBACKGTYPE_data_OutBUS_2REG(BgReg1_2_BgReg0),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(P0Jugabilidad_load_2_BgRegs),
	.SC_RegBACKGTYPE_data_InBUS(BgReg2_2_BgReg1)
);
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS)) SC_RegBACKGTYPE_u0 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS_2DISP(Player0_Backg0),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(P0Jugabilidad_load_2_BgRegs),
	.SC_RegBACKGTYPE_data_InBUS(BgReg1_2_BgReg0)
);

//######################################################################
//#	BACKGROUND VISUALIZATION - Player 1 (Izquierda)
//######################################################################

SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS)) SC_RegBACKGTYPE_u17 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS_2DISP(Player1_Backg17),
	.SC_RegBACKGTYPE_data_OutBUS_2REG(BgReg17_2_BgReg16),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(P1Jugabilidad_load_2_BgRegs), // DEBUG STATEMACHINEBACKG_load_cwire  [PARA TODOS]
	.SC_RegBACKGTYPE_data_InBUS(RandRegL_2_BgReg17) // Tomar 4 bits del bus de 8 de RegRandom -
);
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS)) SC_RegBACKGTYPE_u16 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS_2DISP(Player1_Backg16),
	.SC_RegBACKGTYPE_data_OutBUS_2REG(BgReg16_2_BgReg15),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(P1Jugabilidad_load_2_BgRegs), 
	.SC_RegBACKGTYPE_data_InBUS(BgReg17_2_BgReg16) // DEBUG BgReg7_2_BgReg6
); 
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS)) SC_RegBACKGTYPE_u15 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS_2DISP(Player1_Backg15),
	.SC_RegBACKGTYPE_data_OutBUS_2REG(BgReg15_2_BgReg14),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(P1Jugabilidad_load_2_BgRegs),
	.SC_RegBACKGTYPE_data_InBUS(BgReg16_2_BgReg15)
);
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS)) SC_RegBACKGTYPE_u14 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS_2DISP(Player1_Backg14),
	.SC_RegBACKGTYPE_data_OutBUS_2REG(BgReg14_2_BgReg13),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(P1Jugabilidad_load_2_BgRegs),
	.SC_RegBACKGTYPE_data_InBUS(BgReg15_2_BgReg14)
);
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS)) SC_RegBACKGTYPE_u13 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS_2DISP(Player1_Backg13),
	.SC_RegBACKGTYPE_data_OutBUS_2REG(BgReg13_2_BgReg12),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(P1Jugabilidad_load_2_BgRegs),
	.SC_RegBACKGTYPE_data_InBUS(BgReg14_2_BgReg13)
);
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS)) SC_RegBACKGTYPE_u12 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS_2DISP(Player1_Backg12),
	.SC_RegBACKGTYPE_data_OutBUS_2REG(BgReg12_2_BgReg11),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(P1Jugabilidad_load_2_BgRegs),
	.SC_RegBACKGTYPE_data_InBUS(BgReg13_2_BgReg12)
);
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS)) SC_RegBACKGTYPE_u11 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS_2DISP(Player1_Backg11),
	.SC_RegBACKGTYPE_data_OutBUS_2REG(BgReg11_2_BgReg10),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(P1Jugabilidad_load_2_BgRegs),
	.SC_RegBACKGTYPE_data_InBUS(BgReg12_2_BgReg11)
);
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS)) SC_RegBACKGTYPE_u10 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS_2DISP(Player1_Backg10),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(P1Jugabilidad_load_2_BgRegs),
	.SC_RegBACKGTYPE_data_InBUS(BgReg11_2_BgReg10)
);

//######################################################################
//#	BACKGROUND VISUALIZATION - OUTPUT CONCATENATION	
//######################################################################

assign RegBACKGTYPE_2_BACKGMATRIX_data7_Out = {Player0_Backg7[3:0], Player1_Backg17[3:0]};
assign RegBACKGTYPE_2_BACKGMATRIX_data6_Out = {Player0_Backg6[3:0], Player1_Backg16[3:0]};
assign RegBACKGTYPE_2_BACKGMATRIX_data5_Out = {Player0_Backg5[3:0], Player1_Backg15[3:0]};
assign RegBACKGTYPE_2_BACKGMATRIX_data4_Out = {Player0_Backg4[3:0], Player1_Backg14[3:0]};
assign RegBACKGTYPE_2_BACKGMATRIX_data3_Out = {Player0_Backg3[3:0], Player1_Backg13[3:0]};
assign RegBACKGTYPE_2_BACKGMATRIX_data2_Out = {Player0_Backg2[3:0], Player1_Backg12[3:0]};
assign RegBACKGTYPE_2_BACKGMATRIX_data1_Out = {Player0_Backg1[3:0], Player1_Backg11[3:0]};
assign RegBACKGTYPE_2_BACKGMATRIX_data0_Out = {Player0_Backg0[3:0], Player1_Backg10[3:0]};

//######################################################################
//#	SPEED 7 BACKGROUNDS LOGIC 
//######################################################################

// PLAYER u0 --------------------------------------------------------------------------
SC_upSPEEDCOUNTER SC_upSPEEDCOUNTER_u0(
	.SC_upSPEEDCOUNTER_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_upSPEEDCOUNTER_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_upSPEEDCOUNTER_upcount_InLow(1'b0),
	.SC_upSPEEDCOUNTER_data_OutBUS(SPEEDCOUNTER_2_SPEEDCOMPARATOR)
);

CC_SPEEDCOMPARATOR CC_SPEEDCOMPARATOR_u0 (
	.CC_SPEEDCOMPARATOR_data_InBUS(SPEEDCOUNTER_2_SPEEDCOMPARATOR),
	.CC_SPEEDCOMPARATOR_T0_OutLow(SPEEDCOMPARATOR_2_STATEMACHINEBACKG_T0_cwire)
);

SC_STATEMACHINEBACKG SC_STATEMACHINEBACKG_u0 (
// port map - connection between master ports and signals/registers   
	.SC_STATEMACHINEBACKG_clear_OutLow(STATEMACHINEBACKG_clear_cwire), 
	.SC_STATEMACHINEBACKG_load_OutLow(STATEMACHINEBACKG_load_cwire), 
	.SC_STATEMACHINEBACKG_upcount_out(STATEMACHINEBACKG_upcount_cwire),
	.SC_STATEMACHINEBACKG_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_STATEMACHINEBACKG_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_STATEMACHINEBACKG_startButton_InLow(BB_SYSTEM_startButton_InLow_cwire),
	.SC_STATEMACHINEBACKG_T0_InLow(SPEEDCOMPARATOR_2_STATEMACHINEBACKG_T0_cwire)
);

// Statemachine para garantizar jugabilidad en obstáculos para el player 0
CC_Jugabilidad CC_Jugabilidad_u0( 
    .Player_CC_Jugabilidad_data_InBUS(RandP0_2_Playability),
    .CC_Jugabilidad_load_InLow(STATEMACHINEBACKG_load_cwire),
    .CC_Jugabilidad_CLOCK_50(BB_SYSTEM_CLOCK_50),
    .CC_Jugabilidad_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	 .CC_Jugabilidad_BackregsLoadInLow(P0Jugabilidad_load_2_BgRegs),
	 .Player_CC_Jugabilidad_data_OutBUS(RandRegR_2_BgReg7)
);


// PLAYER u1 --------------------------------------------------------------------------
SC_upSPEEDCOUNTER SC_upSPEEDCOUNTER_u1(
	.SC_upSPEEDCOUNTER_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_upSPEEDCOUNTER_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_upSPEEDCOUNTER_upcount_InLow(1'b0),
	.SC_upSPEEDCOUNTER_data_OutBUS(SPEEDCOUNTER_2_SPEEDCOMPARATOR1)
);

CC_SPEEDCOMPARATOR CC_SPEEDCOMPARATOR_u1 (
	.CC_SPEEDCOMPARATOR_data_InBUS(SPEEDCOUNTER_2_SPEEDCOMPARATOR1),
	.CC_SPEEDCOMPARATOR_T0_OutLow(SPEEDCOMPARATOR_2_STATEMACHINEBACKG_T0_cwire1)
);

SC_STATEMACHINEBACKG SC_STATEMACHINEBACKG_u1 (
// port map - connection between master ports and signals/registers   
	.SC_STATEMACHINEBACKG_clear_OutLow(STATEMACHINEBACKG_clear_cwire1), 
	.SC_STATEMACHINEBACKG_load_OutLow(STATEMACHINEBACKG_load_cwire1), 
	.SC_STATEMACHINEBACKG_upcount_out(STATEMACHINEBACKG_upcount_cwire1),
	.SC_STATEMACHINEBACKG_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_STATEMACHINEBACKG_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_STATEMACHINEBACKG_startButton_InLow(BB_SYSTEM_startButton_InLow_cwire),
	.SC_STATEMACHINEBACKG_T0_InLow(SPEEDCOMPARATOR_2_STATEMACHINEBACKG_T0_cwire1)
);

// Statemachine para garantizar jugabilidad en obstáculos para el player 1
CC_Jugabilidad CC_Jugabilidad_u1( 
    .Player_CC_Jugabilidad_data_InBUS(RandP1_2_Playability),
    .CC_Jugabilidad_load_InLow(STATEMACHINEBACKG_load_cwire1),
    .CC_Jugabilidad_CLOCK_50(BB_SYSTEM_CLOCK_50),
    .CC_Jugabilidad_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	 .CC_Jugabilidad_BackregsLoadInLow(P1Jugabilidad_load_2_BgRegs),
	 .Player_CC_Jugabilidad_data_OutBUS(RandRegL_2_BgReg17)
);


//######################################################################
//#	TO LED MATRIZ: VISUALIZATION
//######################################################################
assign regGAME_data0_wire = RegBACKGTYPE_2_BACKGMATRIX_data0_Out | RegPOINTTYPE_2_POINTMATRIX_data0_Out;
assign regGAME_data1_wire = RegBACKGTYPE_2_BACKGMATRIX_data1_Out;
assign regGAME_data2_wire = RegBACKGTYPE_2_BACKGMATRIX_data2_Out;
assign regGAME_data3_wire = RegBACKGTYPE_2_BACKGMATRIX_data3_Out;
assign regGAME_data4_wire = RegBACKGTYPE_2_BACKGMATRIX_data4_Out;
assign regGAME_data5_wire = RegBACKGTYPE_2_BACKGMATRIX_data5_Out;
assign regGAME_data6_wire = RegBACKGTYPE_2_BACKGMATRIX_data6_Out;
assign regGAME_data7_wire = RegBACKGTYPE_2_BACKGMATRIX_data7_Out;

assign data_max =(add==3'b000)?{regGAME_data0_wire[7],regGAME_data1_wire[7],regGAME_data2_wire[7],regGAME_data3_wire[7],regGAME_data4_wire[7],regGAME_data5_wire[7],regGAME_data6_wire[7],regGAME_data7_wire[7]}:
	       (add==3'b001)?{regGAME_data0_wire[6],regGAME_data1_wire[6],regGAME_data2_wire[6],regGAME_data3_wire[6],regGAME_data4_wire[6],regGAME_data5_wire[6],regGAME_data6_wire[6],regGAME_data7_wire[6]}:
	       (add==3'b010)?{regGAME_data0_wire[5],regGAME_data1_wire[5],regGAME_data2_wire[5],regGAME_data3_wire[5],regGAME_data4_wire[5],regGAME_data5_wire[5],regGAME_data6_wire[5],regGAME_data7_wire[5]}:
	       (add==3'b011)?{regGAME_data0_wire[4],regGAME_data1_wire[4],regGAME_data2_wire[4],regGAME_data3_wire[4],regGAME_data4_wire[4],regGAME_data5_wire[4],regGAME_data6_wire[4],regGAME_data7_wire[4]}:
	       (add==3'b100)?{regGAME_data0_wire[3],regGAME_data1_wire[3],regGAME_data2_wire[3],regGAME_data3_wire[3],regGAME_data4_wire[3],regGAME_data5_wire[3],regGAME_data6_wire[3],regGAME_data7_wire[3]}:
	       (add==3'b101)?{regGAME_data0_wire[2],regGAME_data1_wire[2],regGAME_data2_wire[2],regGAME_data3_wire[2],regGAME_data4_wire[2],regGAME_data5_wire[2],regGAME_data6_wire[2],regGAME_data7_wire[2]}:
	       (add==3'b110)?{regGAME_data0_wire[1],regGAME_data1_wire[1],regGAME_data2_wire[1],regGAME_data3_wire[1],regGAME_data4_wire[1],regGAME_data5_wire[1],regGAME_data6_wire[1],regGAME_data7_wire[1]}:
						{regGAME_data0_wire[0],regGAME_data1_wire[0],regGAME_data2_wire[0],regGAME_data3_wire[0],regGAME_data4_wire[0],regGAME_data5_wire[0],regGAME_data6_wire[0],regGAME_data7_wire[0]};
									 
matrix_ctrl matrix_ctrl_unit_0( 
.max7219_din(BB_SYSTEM_max7219DIN_Out),//max7219_din 
.max7219_ncs(BB_SYSTEM_max7219NCS_Out),//max7219_ncs 
.max7219_clk(BB_SYSTEM_max7219CLK_Out),//max7219_clk
.disp_data(data_max), 
.disp_addr(add),
.intensity(4'hA),
.clk(BB_SYSTEM_CLOCK_50),
.reset(BB_SYSTEM_RESET_InHigh) //~lowRst_System
 ); 
 


//######################################################################
//#	TO TEST
//######################################################################


//######################################################################
//#	TO 7SEG
//######################################################################
CC_BIN2BCD1 CC_BIN2BCD1_u0 (
// port map - connection between master ports and signals/registers   
	.CC_BIN2BCD_bcd_OutBUS(BIN2BCD1_2_SEVENSEG1_data_BUS_wire),
	.CC_BIN2BCD_bin_InBUS(upCOUNTER_2_BIN2BCD1_data_BUS_wire)
);

CC_SEVENSEG1 CC_SEVENSEG1_u0 (
// port map - connection between master ports and signals/registers   
	.CC_SEVENSEG1_an(BB_SYSTEM_display_OutBUS[11:8]),
	.CC_SEVENSEG1_a(BB_SYSTEM_display_OutBUS[0]),
	.CC_SEVENSEG1_b(BB_SYSTEM_display_OutBUS[1]),
	.CC_SEVENSEG1_c(BB_SYSTEM_display_OutBUS[2]),
	.CC_SEVENSEG1_d(BB_SYSTEM_display_OutBUS[3]),
	.CC_SEVENSEG1_e(BB_SYSTEM_display_OutBUS[4]),
	.CC_SEVENSEG1_f(BB_SYSTEM_display_OutBUS[5]),
	.CC_SEVENSEG1_g(BB_SYSTEM_display_OutBUS[6]),
	.CC_SEVENSEG1_dp(BB_SYSTEM_display_OutBUS[7]),
	.CC_SEVENSEG1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.CC_SEVENSEG1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.CC_SEVENSEG1_in0(BIN2BCD1_2_SEVENSEG1_data_BUS_wire[3:0]),
	.CC_SEVENSEG1_in1(BIN2BCD1_2_SEVENSEG1_data_BUS_wire[7:4]),
	.CC_SEVENSEG1_in2(BIN2BCD1_2_SEVENSEG1_data_BUS_wire[11:8]),
	.CC_SEVENSEG1_in3(BIN2BCD1_2_SEVENSEG1_data_BUS_wire[11:8])
);



endmodule
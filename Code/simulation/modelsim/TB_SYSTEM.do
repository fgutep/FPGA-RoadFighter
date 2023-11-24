do BB_SYSTEM_run_msim_rtl_verilog.do
onerror {resume}
quietly WaveActivateNextPane {} 0
delete wave *
add wave -noupdate /TB_SYSTEM/eachvec

add wave  -divider LedMATRIX
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_CLOCK_50
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_RESET_InHigh
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_startButton_InLow
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_leftButton_InLow
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_rightButton_InLow

##add wave -noupdate /TB_SYSTEM/TB_SYSTEM_max7219DIN_Out
##add wave -noupdate /TB_SYSTEM/TB_SYSTEM_max7219NCS_Out
##add wave -noupdate /TB_SYSTEM/TB_SYSTEM_max7219CLK_Out

## ------ Botones ----------------
#add wave  -divider SC_DEBOUNCE1_u0
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u0/SC_DEBOUNCE1_button_In
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u0/SC_DEBOUNCE1_button_Out

#add wave  -divider SC_DEBOUNCE1_u1
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u1/SC_DEBOUNCE1_button_In
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u1/SC_DEBOUNCE1_button_Out

#add wave  -divider SC_DEBOUNCE1_u2
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u2/SC_DEBOUNCE1_button_In
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u2/SC_DEBOUNCE1_button_Out

##add wave  -divider SC_RegRANDOM
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegRANDOM_u0/SC_RegRANDOMOutRightBUS
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegRANDOM_u0/SC_RegRANDOMOutLeftBUS


## Regs PUNTO (Avatar) [Player 0] -------------------------------------------------------------------:
#add wave  -divider PLAYER_0_AVATAR


#add wave  -divider SC_RegSHIFTER_u0
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegSHIFTER_u0/SC_RegSHIFTER_data_InBUS
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegSHIFTER_u0/SC_RegSHIFTER_shiftselection_In
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegSHIFTER_u0/SC_RegSHIFTER_load_InLow
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegSHIFTER_u0/SC_RegSHIFTER_data_OutBUS

## Regs PUNTO (Avatar) [Player 1] -------------------------------------------------------------------:
#add wave  -divider PLAYER_1_AVATAR


#add wave  -divider SC_RegSHIFTER_u1 
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegSHIFTER_u1/SC_RegSHIFTER_data_InBUS
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegSHIFTER_u1/SC_RegSHIFTER_shiftselection_In
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegSHIFTER_u1/SC_RegSHIFTER_load_InLow
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegSHIFTER_u1/SC_RegSHIFTER_data_OutBUS
## Jugabilidad [Ambas Salidas] -----------------------------------------------------------------------: 
##add wave  -divider CC_JUGABILIDAD

#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_Jugabilidad_u0/CC_Jugabilidad_BackregsLoadInLow
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_Jugabilidad_u0/STATE_Register
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_Jugabilidad_u0/STATE_Signal
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_Jugabilidad_u0/SHOULDSEND


## Regs BackType [Player 0]  -----------------------------------------------------------------------: 
add wave  -divider PLAYER_0_BACKG

add wave  -divider SC_RegRANDOM_u0_RightOutput
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegRANDOM_u0/SC_RegRANDOMOutRightBUS


add wave  -divider SC_RegBACKGTYPE_u7
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u7/SC_RegBACKGTYPE_data_InBUS
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u7/SC_RegBACKGTYPE_data_OutBUS_2REG
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u7/SC_RegBACKGTYPE_data_OutBUS_2DISP

add wave  -divider SC_RegBACKGTYPE_u6
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u6/SC_RegBACKGTYPE_data_InBUS
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u6/SC_RegBACKGTYPE_data_OutBUS_2REG
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u6/SC_RegBACKGTYPE_data_OutBUS_2DISP

## Regs BackType [Player 1]  -----------------------------------------------------------------------: 
add wave  -divider PLAYER_1_BACKG

add wave  -divider SC_RegRANDOM_u0_LeftOutput
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegRANDOM_u0/SC_RegRANDOMOutLeftBUS

add wave  -divider SC_RegBACKGTYPE_u17
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u17/SC_RegBACKGTYPE_data_InBUS
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u17/SC_RegBACKGTYPE_data_OutBUS_2REG
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u17/SC_RegBACKGTYPE_data_OutBUS_2DISP
# For u_6
add wave  -divider SC_RegBACKGTYPE_u16
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u16/SC_RegBACKGTYPE_data_InBUS
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u16/SC_RegBACKGTYPE_data_OutBUS_2REG
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u16/SC_RegBACKGTYPE_data_OutBUS_2DISP

# For u_5
##add wave  -divider SC_RegBACKGTYPE_u5
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u5/SC_RegBACKGTYPE_data_InBUS
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u5/SC_RegBACKGTYPE_data_OutBUS_2REG
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u5/SC_RegBACKGTYPE_data_OutBUS_2DISP

# For u_4
##add wave  -divider SC_RegBACKGTYPE_u4
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u4/SC_RegBACKGTYPE_data_InBUS
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u4/SC_RegBACKGTYPE_data_OutBUS_2REG
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u4/SC_RegBACKGTYPE_data_OutBUS_2DISP

# For u_3
##add wave  -divider SC_RegBACKGTYPE_u3
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u3/SC_RegBACKGTYPE_data_InBUS
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u3/SC_RegBACKGTYPE_data_OutBUS_2REG
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u3/SC_RegBACKGTYPE_data_OutBUS_2DISP

# For u_2
##add wave  -divider SC_RegBACKGTYPE_u2
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u2/SC_RegBACKGTYPE_data_InBUS
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u2/SC_RegBACKGTYPE_data_OutBUS_2REG
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u2/SC_RegBACKGTYPE_data_OutBUS_2DISP

# For u_1
##add wave  -divider SC_RegBACKGTYPE_u4
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u1/SC_RegBACKGTYPE_data_InBUS
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u1/SC_RegBACKGTYPE_data_OutBUS_2REG
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u1/SC_RegBACKGTYPE_data_OutBUS_2DISP

# For u_0
#add wave  -divider SC_RegBACKGTYPE_u0_bstacles_Y_Player
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u0/SC_RegBACKGTYPE_data_InBUS
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u0/SC_RegBACKGTYPE_data_OutBUS_2REG
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegBACKGTYPE_u0/SC_RegBACKGTYPE_data_OutBUS_2DISP


# Salida de Display - Punto
add wave  -divider Desplazamiento_Jugador_0_IZQ
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/Wire_Out_Shift_P1
add wave  -divider Desplazamiento_Jugador_1_DER
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/Wire_Out_Shift_P0
add wave  -divider Salida_Concatenada
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/RegPOINTTYPE_2_POINTMATRIX_data0_Out
add wave  -divider Salida_ConcatenadayRegBackgDisplay
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/regGAME_data0_wire



## Speed Management:
#add wave  -divider SC_upSPEEDCOUNTER_u0
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_upSPEEDCOUNTER_u0/SC_upSPEEDCOUNTER_upcount_InLow
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_upSPEEDCOUNTER_u0/SC_upSPEEDCOUNTER_data_OutBUS

#add wave  -divider CC_SPEEDCOMPARATOR_u0
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_SPEEDCOMPARATOR_u0/CC_SPEEDCOMPARATOR_data_InBUS
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_SPEEDCOMPARATOR_u0/CC_SPEEDCOMPARATOR_T0_OutLow

# --- BAckGStateMachine_u0 -------
add wave -divider SC_STATEMACHINEBACKG_u0
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_STATEMACHINEBACKG_u0/SC_STATEMACHINEBACKG_load_OutLow
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_STATEMACHINEBACKG_u0/STATE_Register 
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_STATEMACHINEBACKG_u0/STATE_Signal
# --- BAckGStateMachine_u1 -------
add wave -divider SC_STATEMACHINEBACKG_u1
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_STATEMACHINEBACKG_u1/SC_STATEMACHINEBACKG_load_OutLow
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_STATEMACHINEBACKG_u1/STATE_Register 
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_STATEMACHINEBACKG_u1/STATE_Signal

restart
run 500ms

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {319999492 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 445
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {59829352 ps} {60892417 ps}

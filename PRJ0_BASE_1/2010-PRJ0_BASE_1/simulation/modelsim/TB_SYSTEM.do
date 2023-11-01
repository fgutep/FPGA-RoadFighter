do BB_SYSTEM_run_msim_rtl_verilog.do
onerror {resume}
quietly WaveActivateNextPane {} 0
delete wave *
add wave -noupdate /TB_SYSTEM/eachvec

add wave  -divider BB_SYSTEM_INs
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_CLOCK_50
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_RESET_InHigh
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_startButton_InLow
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_leftButton_InLow
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_rightButton_InLow

add wave  -divider BB_SYSTEM_OUTs
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_max7219DIN_Out
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_max7219NCS_Out
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_max7219CLK_Out

add wave  -divider SC_DEBOUNCE1_u0
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u0/SC_DEBOUNCE1_button_In
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u0/SC_DEBOUNCE1_button_Out

add wave  -divider SC_DEBOUNCE1_u1
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u1/SC_DEBOUNCE1_button_In
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u1/SC_DEBOUNCE1_button_Out

add wave  -divider SC_DEBOUNCE1_u2
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u2/SC_DEBOUNCE1_button_In
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u2/SC_DEBOUNCE1_button_Out

add wave  -divider SC_DEBOUNCE1_u3
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u2/SC_DEBOUNCE1_button_In
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u2/SC_DEBOUNCE1_button_Out

add wave  -divider SC_DEBOUNCE1_u4
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u2/SC_DEBOUNCE1_button_In
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u2/SC_DEBOUNCE1_button_Out

add wave  -divider MATRIX
add wave -radix Binary /TB_SYSTEM/BB_SYSTEM_u0/regGAME_data7_wire
add wave -radix Binary /TB_SYSTEM/BB_SYSTEM_u0/regGAME_data6_wire
add wave -radix Binary /TB_SYSTEM/BB_SYSTEM_u0/regGAME_data5_wire
add wave -radix Binary /TB_SYSTEM/BB_SYSTEM_u0/regGAME_data4_wire
add wave -radix Binary /TB_SYSTEM/BB_SYSTEM_u0/regGAME_data3_wire
add wave -radix Binary /TB_SYSTEM/BB_SYSTEM_u0/regGAME_data2_wire
add wave -radix Binary /TB_SYSTEM/BB_SYSTEM_u0/regGAME_data1_wire
add wave -radix Binary /TB_SYSTEM/BB_SYSTEM_u0/regGAME_data0_wire

add wave  -divider SC_RegPOINTTYPE
add wave  -radix Binary /TB_SYSTEM/BB_SYSTEM_u0/SC_RegPOINTTYPE_u0/SC_RegSHIFTER_data_OutBUS

add wave  -divider STATEMACHINEPOINT_u0
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_STATEMACHINEPOINT_u0/SC_STATEMACHINEPOINT_startButton_InLow
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_STATEMACHINEPOINT_u0/SC_STATEMACHINEPOINT_leftButton_InLow
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_STATEMACHINEPOINT_u0/SC_STATEMACHINEPOINT_rightButton_InLow
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_STATEMACHINEPOINT_u0/SC_STATEMACHINEPOINT_clear_OutLow
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_STATEMACHINEPOINT_u0/SC_STATEMACHINEPOINT_load_OutLow
add wave -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/SC_STATEMACHINEPOINT_u0/SC_STATEMACHINEPOINT_shiftselection_Out
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_STATEMACHINEPOINT_u0/SC_STATEMACHINEPOINT_sidecomparator_InLow
add wave -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/SC_STATEMACHINEPOINT_u0/STATE_Register

add wave  -divider SC_upCOUNTER_u0
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_upCOUNTER_u0/SC_upCOUNTER_data_OutBUS

add wave  -divider CC_BIN2BCD1_u0
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_BIN2BCD1_u0/CC_BIN2BCD_bcd_OutBUS

add wave  -divider CC_SEVENSEG1_u0
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_SEVENSEG1_u0/CC_SEVENSEG1_an
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_SEVENSEG1_u0/CC_SEVENSEG1_a
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_SEVENSEG1_u0/CC_SEVENSEG1_b
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_SEVENSEG1_u0/CC_SEVENSEG1_c
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_SEVENSEG1_u0/CC_SEVENSEG1_d
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_SEVENSEG1_u0/CC_SEVENSEG1_e
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_SEVENSEG1_u0/CC_SEVENSEG1_f
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_SEVENSEG1_u0/CC_SEVENSEG1_g

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

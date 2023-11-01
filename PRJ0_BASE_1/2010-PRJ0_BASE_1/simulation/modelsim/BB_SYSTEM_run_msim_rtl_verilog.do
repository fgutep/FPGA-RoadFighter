transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1/rtl {C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1/rtl/SC_upCOUNTER.v}
vlog -vlog01compat -work work +incdir+C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1/rtl {C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1/rtl/SC_STATEMACHINEPOINT.v}
vlog -vlog01compat -work work +incdir+C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1/rtl {C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1/rtl/SC_RegSHIFTER.v}
vlog -vlog01compat -work work +incdir+C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1/rtl {C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1/rtl/CC_SIDECOMPARATOR.v}
vlog -vlog01compat -work work +incdir+C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1/rtl {C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1/rtl/CC_SEVENSEG1.v}
vlog -vlog01compat -work work +incdir+C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1/rtl {C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1/rtl/CC_BIN2BCD1.v}
vlog -vlog01compat -work work +incdir+C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1/rtl {C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1/rtl/shift_reg_start_done.v}
vlog -vlog01compat -work work +incdir+C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1/rtl {C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1/rtl/max7219_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1/rtl {C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1/rtl/SC_DEBOUNCE1.v}
vlog -vlog01compat -work work +incdir+C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1 {C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1/BB_SYSTEM.v}

vlog -vlog01compat -work work +incdir+C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1/simulation/modelsim {C:/Users/Camilo/Downloads/PRJ0_BASE_1/2010-PRJ0_BASE_1/simulation/modelsim/TB_SYSTEM.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  TB_SYSTEM

add wave *
view structure
view signals
run -all

transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {BB_SYSTEM_6_1200mv_85c_slow.vo}

vlog -vlog01compat -work work +incdir+C:/Users/f.gutierreza/Downloads/QA161123-1305PM/QA161123-1305PM/QA161123-1225AM/QA161123/simulation/modelsim {C:/Users/f.gutierreza/Downloads/QA161123-1305PM/QA161123-1305PM/QA161123-1225AM/QA161123/simulation/modelsim/TB_SYSTEM.vt}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  TB_SYSTEM

add wave *
view structure
view signals
run -all

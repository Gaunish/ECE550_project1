transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

<<<<<<< HEAD
vlog -vlog01compat -work work +incdir+. {regfile_7_1200mv_85c_slow.vo}

vlog -vlog01compat -work work +incdir+E:/ECE550_Project1/Reg-file {E:/ECE550_Project1/Reg-file/regfile_tb.v}
=======
vlog -vlog01compat -work work +incdir+. {regfile_min_1200mv_0c_fast.vo}

vlog -vlog01compat -work work +incdir+C:/Users/86156/Documents/GitHub/ECE550_project1/Reg-file {C:/Users/86156/Documents/GitHub/ECE550_project1/Reg-file/regfile_tb.v}
>>>>>>> f7ff96b18fc0a81580d59c30d29958413a48dc26

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  regfile_tb

add wave *
view structure
view signals
run -all

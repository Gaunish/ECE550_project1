transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

<<<<<<< HEAD
vlog -vlog01compat -work work +incdir+E:/ECE550_Project1/Reg-file {E:/ECE550_Project1/Reg-file/regfile.v}
vlog -vlog01compat -work work +incdir+E:/ECE550_Project1/Reg-file {E:/ECE550_Project1/Reg-file/dffe_ref.v}
vlog -vlog01compat -work work +incdir+E:/ECE550_Project1/Reg-file {E:/ECE550_Project1/Reg-file/register.v}
vlog -vlog01compat -work work +incdir+E:/ECE550_Project1/Reg-file {E:/ECE550_Project1/Reg-file/decoder_2.v}
vlog -vlog01compat -work work +incdir+E:/ECE550_Project1/Reg-file {E:/ECE550_Project1/Reg-file/decoder_3.v}
vlog -vlog01compat -work work +incdir+E:/ECE550_Project1/Reg-file {E:/ECE550_Project1/Reg-file/decoder_5.v}
vlog -vlog01compat -work work +incdir+E:/ECE550_Project1/Reg-file {E:/ECE550_Project1/Reg-file/tristate.v}

vlog -vlog01compat -work work +incdir+E:/ECE550_Project1/Reg-file {E:/ECE550_Project1/Reg-file/regfile_tb.v}
=======
<<<<<<< Updated upstream
vlog -vlog01compat -work work +incdir+E:/Project/Reg-file {E:/Project/Reg-file/dffe_ref.v}
vlog -vlog01compat -work work +incdir+E:/Project/Reg-file {E:/Project/Reg-file/register.v}
vlog -vlog01compat -work work +incdir+E:/Project/Reg-file {E:/Project/Reg-file/regfile_imp.v}

=======
vlog -vlog01compat -work work +incdir+C:/Users/86156/Documents/GitHub/ECE550_project1/Reg-file {C:/Users/86156/Documents/GitHub/ECE550_project1/Reg-file/decoder_5.v}
vlog -vlog01compat -work work +incdir+C:/Users/86156/Documents/GitHub/ECE550_project1/Reg-file {C:/Users/86156/Documents/GitHub/ECE550_project1/Reg-file/decoder_3.v}
vlog -vlog01compat -work work +incdir+C:/Users/86156/Documents/GitHub/ECE550_project1/Reg-file {C:/Users/86156/Documents/GitHub/ECE550_project1/Reg-file/decoder_2.v}
vlog -vlog01compat -work work +incdir+C:/Users/86156/Documents/GitHub/ECE550_project1/Reg-file {C:/Users/86156/Documents/GitHub/ECE550_project1/Reg-file/regfile.v}
vlog -vlog01compat -work work +incdir+C:/Users/86156/Documents/GitHub/ECE550_project1/Reg-file {C:/Users/86156/Documents/GitHub/ECE550_project1/Reg-file/dffe_ref.v}
vlog -vlog01compat -work work +incdir+C:/Users/86156/Documents/GitHub/ECE550_project1/Reg-file {C:/Users/86156/Documents/GitHub/ECE550_project1/Reg-file/register.v}
vlog -vlog01compat -work work +incdir+C:/Users/86156/Documents/GitHub/ECE550_project1/Reg-file {C:/Users/86156/Documents/GitHub/ECE550_project1/Reg-file/tristate.v}

vlog -vlog01compat -work work +incdir+C:/Users/86156/Documents/GitHub/ECE550_project1/Reg-file {C:/Users/86156/Documents/GitHub/ECE550_project1/Reg-file/regfile_tb.v}
>>>>>>> f7ff96b18fc0a81580d59c30d29958413a48dc26

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  regfile_tb

add wave *
view structure
view signals
run -all
<<<<<<< HEAD
=======
>>>>>>> Stashed changes
>>>>>>> f7ff96b18fc0a81580d59c30d29958413a48dc26

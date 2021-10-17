transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/Project/Reg-file {E:/Project/Reg-file/dffe_ref.v}
vlog -vlog01compat -work work +incdir+E:/Project/Reg-file {E:/Project/Reg-file/register.v}
vlog -vlog01compat -work work +incdir+E:/Project/Reg-file {E:/Project/Reg-file/regfile_imp.v}


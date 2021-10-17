onerror {exit -code 1}
vlib work
vlog -work work regfile.vo
<<<<<<< Updated upstream
vlog -work work Waveform.vwf.vt
=======
vlog -work work regFile.vwf.vt
>>>>>>> Stashed changes
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate_ver -L altera_lnsim_ver work.regfile_vlg_vec_tst -voptargs="+acc"
vcd file -direction regfile.msim.vcd
vcd add -internal regfile_vlg_vec_tst/*
vcd add -internal regfile_vlg_vec_tst/i1/*
run -all
quit -f

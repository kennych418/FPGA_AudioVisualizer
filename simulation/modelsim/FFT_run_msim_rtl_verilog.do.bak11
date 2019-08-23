transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/chank/OneDrive/Quartus/FFT {C:/Users/chank/OneDrive/Quartus/FFT/FFT.sv}
vlog -sv -work work +incdir+C:/Users/chank/OneDrive/Quartus/FFT {C:/Users/chank/OneDrive/Quartus/FFT/butterflyunit.sv}
vlog -sv -work work +incdir+C:/Users/chank/OneDrive/Quartus/FFT {C:/Users/chank/OneDrive/Quartus/FFT/complexmultiplier.sv}
vlog -sv -work work +incdir+C:/Users/chank/OneDrive/Quartus/FFT {C:/Users/chank/OneDrive/Quartus/FFT/complexadder.sv}
vlog -sv -work work +incdir+C:/Users/chank/OneDrive/Quartus/FFT {C:/Users/chank/OneDrive/Quartus/FFT/simplemultiplier.sv}
vlog -sv -work work +incdir+C:/Users/chank/OneDrive/Quartus/FFT {C:/Users/chank/OneDrive/Quartus/FFT/complexsubtractor.sv}


vlib work
vlog -f src_files.list +define+SIM +cover -covercells 
vsim -voptargs=+acc work.top -classdebug -uvmcontrol=all -cover
add wave /top/SPIinterface/*
run 0
run -all
coverage save alsu.ucdb -onexit  -du SLAVE


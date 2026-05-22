vlib work
vlog -f src_files.list +cover -covercells
vsim -voptargs=+acc work.WRAPPER_top -classdebug -uvmcontrol=all -cover
add wave /WRAPPER_top/WRAPPER_top_if/*
add wave /WRAPPER_top/spiif/*
add wave /WRAPPER_top/ram_if/*
coverage save -onexit \
    -du WRAPPER \
    -du GM_WRAPPER \
    -du GM_RAM \
    -du RAM \
    -du GM_SPI_SLAVE \
    -du SLAVE \
    coverage.ucdb
run -all
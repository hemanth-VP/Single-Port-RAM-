compile:
	vlib work;
	vlog -sv \
	+acc \
	+cover \
	+fcover \
	top.sv 

simulate:
	vsim -vopt work.top \
	-voptargs=+acc=npr \
	-assertdebug \
	-l top.log \
	-sva \
	-coverage \
	-c -do "log -r /*; add wave -r /*; coverage save -onexit -assert -directive -cvg -codeAll top_coverage.ucdb; run -all; exit" \
	-wlf top_waveform.wlf

all:
	make compile
	make simulate

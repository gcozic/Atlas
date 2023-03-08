if {[file isdirectory work]} { vdel -all -lib work }

vlib work
vmap work work

sccom -g SC_NoC/SC_InputModule.cpp
sccom -g SC_NoC/SC_OutputModule.cpp
sccom -g SC_NoC/SC_OutputModuleRouter.cpp
sccom -link

vcom -work work -93 -explicit NOC/Hermes_package.vhd
vcom -work work -93 -explicit NOC/Hermes_buffer.vhd
vcom -work work -93 -explicit NOC/Hermes_switchcontrol.vhd
vcom -work work -93 -explicit NOC_monitores/reg16bit.vhd
vcom -work work -93 -explicit NOC_monitores/Monitor_package.vhd
vcom -work work -93 -explicit NOC/RouterBL.vhd
vcom -work work -93 -explicit NOC/RouterBC.vhd
vcom -work work -93 -explicit NOC/RouterBR.vhd
vcom -work work -93 -explicit NOC/RouterCL.vhd
vcom -work work -93 -explicit NOC/RouterCC.vhd
vcom -work work -93 -explicit NOC/RouterCR.vhd
vcom -work work -93 -explicit NOC/RouterTL.vhd
vcom -work work -93 -explicit NOC/RouterTC.vhd
vcom -work work -93 -explicit NOC/RouterTR.vhd
vcom -work work -93 -explicit NOC_monitores/RouterBL_monitor.vhd
vcom -work work -93 -explicit NOC_monitores/RouterBC_monitor.vhd
vcom -work work -93 -explicit NOC_monitores/RouterBR_monitor.vhd
vcom -work work -93 -explicit NOC_monitores/RouterCL_monitor.vhd
vcom -work work -93 -explicit NOC_monitores/RouterCC_monitor.vhd
vcom -work work -93 -explicit NOC_monitores/RouterCR_monitor.vhd
vcom -work work -93 -explicit NOC_monitores/RouterTL_monitor.vhd
vcom -work work -93 -explicit NOC_monitores/RouterTC_monitor.vhd
vcom -work work -93 -explicit NOC_monitores/RouterTR_monitor.vhd
vcom -work work -93 -explicit NOC_monitores/NOC_monitores.vhd
vcom -work work -93 -explicit topNoC.vhd

vsim -t 10ps work.topNoC

set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1
do list.do

run 1 ms

write list list.txt
quit -sim
quit -f


# Cadence Genus(TM) Synthesis Solution, Version 23.10-p004_1, built Feb  1 2024 13:43:46

# Date: Thu Feb 12 10:09:09 2026
# Host: vku-truongsa (x86_64 w/Linux 3.10.0-1160.119.1.el7.x86_64) (4cores*24cpus*6physical cpus*Intel(R) Xeon(R) CPU E5-2667 v2 @ 3.30GHz 25600KB)
# OS:   CentOS Linux release 7.9.2009 (Core)

source ./scripts/synthesis.tcl
read_hdl "addersubtractor_top.v  addersubtractor.v"
read_hdl "addersubtractor.v"
elaborate $DESIGN
elaborate
set_dont_touch [get_cells -hier "*pad*"]
set_dont_touch [get_cells -hier "*corner*"]
change_names -verilog -log_change ${_LOG_PATH}/change_names.log
check_design -unresolved
read_sdc ./rtl/top.sdc
report timing -lint
syn_generic
syn_map
syn_map -physical
syn_opt
report_area
report_summary
exit

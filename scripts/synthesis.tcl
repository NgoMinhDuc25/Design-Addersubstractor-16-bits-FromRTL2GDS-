##=============================================================================
#   Genus version 23.*
#   By: M.Duc - ducnm
##=============================================================================
set_db common_ui false 

if {[file exists /proc/cpuinfo]} {
  sh grep "model name" /proc/cpuinfo
  sh grep "cpu MHz"    /proc/cpuinfo
}

puts "Hostname : [info hostname]"

##############################################################################
## Preset global variables and attributes
##############################################################################

setDesignMode -process 130
set DESIGN top_addersubtractor
set GEN_EFF medium
set MAP_OPT_EFF high

set _OUTPUTS_PATH outputs_atp2
set _REPORTS_PATH reports_atp2
set _LOG_PATH     logs_atp2

foreach dir {_OUTPUTS_PATH _REPORTS_PATH _LOG_PATH} {
    if {![file exists [set $dir]]} {
        file mkdir [set $dir]
        puts "Creating directory [set $dir]"
    }
}

# Configurate lib, rtl, script folder 
set_attribute init_lib_search_path {. ./libraries/lib }
set_attribute script_search_path {. ./scripts}
set_attribute init_hdl_search_path {. ./rtl }

set_attribute information_level 7
set_attr auto_ungroup none

###############################################################
## Library setup (IHP sg13g2)
###############################################################

# Setup lib corner, this preset is generated for mmmc.tcl as output.
# Slow corner
create_library_domain { slow }
set_attribute library {             \
    ./libraries/lib/max/sg13g2_stdcell_slow_1p08V_125C.lib \
    ./libraries/lib/max/sg13g2_stdcell_slow_1p35V_125C.lib \
    ./libraries/lib/max/sg13g2_io_slow_1p35V_3p0V_125C.lib \
    ./libraries/lib/max/sg13g2_io_slow_1p08V_3p0V_125C.lib \
} [find /libraries -library_domain slow]

# Fast corner
create_library_domain { fast }
set_attribute library {             \
    ./libraries/lib/min/sg13g2_stdcell_fast_1p32V_m40C.lib \
    ./libraries/lib/min/sg13g2_stdcell_fast_1p65V_m40C.lib \
    ./libraries/lib/min/sg13g2_io_fast_1p32V_3p6V_m40C.lib \
    ./libraries/lib/min/sg13g2_io_fast_1p65V_3p6V_m40C.lib \
} [find /libraries -library_domain fast]

# Typical corner
create_library_domain { typ }
set_attribute library {             \
    ./libraries/lib/typ/sg13g2_stdcell_typ_1p20V_25C.lib \
    ./libraries/lib/typ/sg13g2_stdcell_typ_1p50V_25C.lib \
    ./libraries/lib/typ/sg13g2_io_typ_1p2V_3p3V_25C.lib \
    ./libraries/lib/typ/sg13g2_io_typ_1p5V_3p3V_25C.lib \
} [find /libraries -library_domain typ]

# Defines analysis view, also be used as output later.
set_attribute power_library [find /libraries -library_domain fast] [find /libraries -library_domain slow] [find /libraries -library_domain typ]
set_attribute default true [find /libraries -library_domain slow]

# LEF (Defines your lef file here)
# Make sure that tech.lef always on the top of the list
set_attribute lef_library {
    ./libraries/tech/lef/sg13g2_tech.lef
    ./libraries/lef/sg13g2_stdcell.lef
    ./libraries/lef/sg13g2_io.lef
    ./libraries/lef/sg13g2_io_notracks.lef
}

set_attribute hdl_array_naming_style %s\[%d\]

# This line is for clock gating, required that you must have clock gating library.
#set_attribute lp_insert_clock_gating true

# Read design, please includes all rtl design files here.
read_hdl {./rtl/addersubtractor_top.v ./rtl/addersubtractor.v ./rtl/mux2to1.v ./rtl/adderk.v}
elaborate $DESIGN

# Vietnamese bellow
# Áp dụng dont_touch ngay sau khi elaborate để bảo vệ Pad và Hierarchy
# Lệnh này sẽ tìm các instance có chữ "pad" hoặc "corner" bạn đã đặt
set_dont_touch [get_cells -hier "*pad*"]
set_dont_touch [get_cells -hier "*corner*"]

puts "Runtime & Memory after 'read_hdl'"
time_info Elaboration

# Dọn dẹp tên netlist để tránh ký tự đặc biệt gây lỗi khi qua Innovus
change_names -verilog -log_change ${_LOG_PATH}/change_names.log
check_design -unresolved

# Giả sử bạn có file SDC quy định timing cho p_Clock
if {[file exists ./rtl/top.sdc]} {
    read_sdc ./rtl/top.sdc
} else {
    puts "Warning: SDC file not found. Please create top.sdc"
}

report timing -lint


# Bảo vệ các khối con cụ thể nếu cần
# Boi vi cac module con nhu mux2to1 va adderk sex duoc tron (dung hop) sau khi elaborate vao trong module cha cua no nen line 118, 119, 121, 122 se warning.
set_attribute ungroup_ok false [find / -subdesign addersubtractor ]
#set_attribute ungroup_ok false [find / -subdesign mux2to1 ]
#set_attribute ungroup_ok false [find / -subdesign adderk ]
set_attribute boundary_opto false [find / -subdesign addersubtractor ]
#set_attribute boundary_opto false [find / -subdesign mux2to1 ]
#set_attribute boundary_opto false [find / -subdesign adderk ]

####################################################################
## Synthesizing
####################################################################

# 1. Generic
set_attribute syn_generic_effort $GEN_EFF
syn_generic 
time_info GENERIC

# 2.  Gates
set_attribute syn_map_effort $MAP_OPT_EFF
syn_map
time_info MAPPED

# 3. Optimization
set_attribute syn_opt_effort $MAP_OPT_EFF
syn_opt
time_info OPT

####################################################################
## Write Outputs
####################################################################

write_snapshot -outdir $_REPORTS_PATH -tag final
report_summary -outdir $_REPORTS_PATH
report_timing   >  $_REPORTS_PATH/timing.rpt
report_area     >  $_REPORTS_PATH/area.rpt

# Netlist sau tổng hợp (Gate-level Verilog)
write_hdl   > ${_OUTPUTS_PATH}/${DESIGN}.vg
write_sdc   > ${_OUTPUTS_PATH}/${DESIGN}.sdc

# Xuất cơ sở dữ liệu cho bước Physical Design (Innovus)
write_db -design $DESIGN -common ${_OUTPUTS_PATH}/${DESIGN}_innovus

puts "Final Runtime & Memory."
time_info FINAL
puts "Synthesis Finished for addersubtractor."
exit



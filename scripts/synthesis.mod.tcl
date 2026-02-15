#### Hiu chnh cho thit k addersubtractor - IHP sg13g2
set_db common_ui false 

# ... (Gi nguyên phn thông tin h thng và khi to th mc) ...

###############################################################
## Library setup (IHP sg13g2)
###############################################################
# (Gi nguyên phn khai báo Library Domain slow/fast/typ và LEF ca bn)
# Đm bo phn này đã chy đúng trc khi tip tc.

####################################################################
## Load Design
####################################################################

set DESIGN top_addersubtractor
read_hdl "addersubtractor_top.v  addersubtractor.v"
elaborate $DESIGN

# --- THAY ĐI QUAN TRNG TI ĐÂY ---
# Thay vì dùng set_dont_touch (gây li syn_generic), ta dùng 'preserve' 
# đ bo v Pad khi b xóa nhng vn cho phép quy trình synthesis din ra.
set_attribute preserve true [get_cells -hier "*pad*"]
set_attribute preserve true [get_cells -hier "*corner*"]

# Bo v hierarchy khi addersubtractor đ không b làm phng (flatten)
set_attribute ungroup_ok false [get_designs addersubtractor]
set_attribute boundary_opto false [get_designs addersubtractor]

puts "Runtime & Memory after 'read_hdl'"
time_info Elaboration

check_design -unresolved

####################################################################
## Constraints Setup
####################################################################
if {[file exists ./rtl/top.sdc]} {
    read_sdc ./rtl/top.sdc
} else {
    puts "Warning: SDC file not found!"
}

# Kim tra timing s b
report timing -lint

####################################################################
## Synthesizing
####################################################################

# 1. To Generic
set_attribute syn_generic_effort $GEN_EFF
# Dùng flag -physical nu thit k có cha sn các cell vt lý (Pads)
syn_generic -physical 
time_info GENERIC

# 2. To Gates
set_attribute syn_map_effort $MAP_OPT_EFF
# Nu vn báo li mapped gate, syn_map s hiu và x lý da trên thuc tính preserve
syn_map
time_info MAPPED

# 3. Optimization
set_attribute syn_opt_effort $MAP_OPT_EFF
syn_opt
time_info OPT

####################################################################
## Write Outputs
####################################################################
# (Gi nguyên phn xut báo cáo và file đu ra ca bn)
exit

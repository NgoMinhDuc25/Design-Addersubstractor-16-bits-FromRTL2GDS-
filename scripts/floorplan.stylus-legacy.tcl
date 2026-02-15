#======================================================================
# floor_plan.both.tcl  (works in BOTH legacy "innovus" and "innovus -stylus")
#======================================================================

#-------------------------
# 0) Detect mode
#-------------------------
set IS_STYLUS 0
if {[info commands is_common_ui_mode] ne ""} {
    if {[is_common_ui_mode]} { set IS_STYLUS 1 }
}
puts "INFO: Running in [expr {$IS_STYLUS ? "Stylus (Common UI)" : "Legacy"}] mode" ;# using switch tech. to display mode

#-------------------------
# 1) Multi-CPU
#-------------------------
set NCPU 4
if {$IS_STYLUS} {
   set_multi_cpu_usage -local_cpu $NCPU
} else {
   setMultiCpuUsage -localCpu $NCPU
}

#-------------------------
# 2) Output directory
#-------------------------
set DBS "./Lab5.floorplan_outputs"
if {![file exists $DBS]} {
    file mkdir $DBS
    puts "INFO: Creating directory $DBS"
}

#-------------------------
# 3) LEF setup (tech + stdcell + memory + IO)
#-------------------------
#       ../libraries/tech/qrc/qx/gpdk045.tch 
 
set LEFS [list \
        ./libraries/tech/lef/sg13g2_tech.lef \
        ./libraries/lef/sg13g2_stdcell.lef \
        ./libraries/lef/sg13g2_io.lef \
        ./libraries/lef/sg13g2_io_notracks.lef \
]

if {$IS_STYLUS} {
    # Stylus
    read_physical -lef $LEFS
} else {
    # Legacy
    set init_lef_file $LEFS
}

#-------------------------
# 4) Netlist / top-cell setup
#-------------------------
set NETLIST ./outputs/top_addersubtractor.vg 
set TOPCELL top_addersubtractor 

if {$IS_STYLUS} {
    # In Stylus we will read netlist later (after read_mmmc) below.
} else {
    set init_design_netlisttype Verilog
    set init_verilog           $NETLIST
    set init_design_settop     1
    set init_top_cell          $TOPCELL
}

#-------------------------
# 5) MMMC setup
#-------------------------

create_rc_corner -name my_rc_corner \
    -qrc_tech ./libraries/tech/qrc/sg13g2_typ.itf \
    -temperature 25

if {$IS_STYLUS} {
    read_mmmc ./scripts/Feb142026_mmmc.mod.tcl
    read_netlist $NETLIST -top $TOPCELL
} else {
    set init_mmmc_file ./scripts/viewDefinition.tcl
}

#-------------------------
# 6) Initialize design
#-------------------------
init_design
puts "=====> Debugger here: Stop program."
return
#======================================================================
# 7) FLOORPLAN (Part A): IO-driven fixed-dimension die/core sizing
#
# Design: cpu_16bit_top
# - 37 signal IO ports (3 ctrl + 16 din + 16 dout + 2 status)
# - Pad rule: per side insert 2 power pads (VDD and VSS)
#   Sequence example: p1 p2 p3 VDD  p4 p5 p6 VSS  p7 p8 p9 ...
#
# IO LEF dimensions (pdkIO.lef):
# - IO pad cell SIZE 40 x 250  -> pitch along edge = 40, IO ring thickness = 250
# - Corner cell   SIZE 250 x 250
#
# Pad distribution used for sizing (signals only):
#   Top=10, Bottom=9, Left=9, Right=9  (total 37)
# Add per-side PG pads (VDD+VSS):
#   Npads_top   = 10 + 2 = 12
#   Npads_bot   =  9 + 2 = 11
#   Npads_left  =  9 + 2 = 11
#   Npads_right =  9 + 2 = 11
#
# Die sizing (min):
#   dieW = corner(250) + max(Npads_top,Npads_bot)*pitch(40) + corner(250)
#        = 250 + max(12,11)*40 + 250 = 980
#   dieH = corner(250) + max(Npads_left,Npads_right)*pitch(40) + corner(250)
#        = 250 + max(11,11)*40 + 250 = 940
#
# Margin intent:
#   IO ring thickness 250 + clearance 50 => die->core margin = 300
#   => L=B=R=T = 300 measured from DIE edge to CORE edge
#
# IMPORTANT (Innovus behavior):
# - Use "die" interpretation so 300 means DIE->CORE margin.
# - Tool may snap to placement grid (e.g., 300 -> 300.01, 940 -> 939.93). OK.
#
# Commands:
#   Legacy : floorPlan -site CoreSite -coreMarginsBy die -d {980 940 300 300 300 300}
#   Stylus : create_floorplan -site CoreSite -core_margins_by die -die_size 980 940 300 300 300 300
#======================================================================

set DIE_W 980
set DIE_H 940
set MARG  300

if {$IS_STYLUS} {
    # --- Stylus / Common UI ---
    create_floorplan -site CoreSite -core_margins_by die -die_size $DIE_W $DIE_H $MARG $MARG $MARG $MARG
    gui_set_draw_view fplan 
    gui_fit 
    get_db current_design .core_bbox
} else {
    # --- Legacy ---
    floorPlan -site CoreSite -coreMarginsBy die -d [list $DIE_W $DIE_H $MARG $MARG $MARG $MARG]
    setDrawView fplan
    fit
    puts "DIE  [dbGet top.fPlan.box]"
    puts "CORE [dbGet top.fPlan.coreBox]"
}

#-------------------------
# Move all IO cells to it's original location 0,0
#-------------------------
set my_ios [get_db [get_db hinsts cpu_16bit_top/U_IO] .local_insts]
set_db $my_ios .location {0 0}
gui_redraw

#-------------------------
# 8) Save floorplan checkpoint (portable: Stylus + Legacy)
#-------------------------
set SESSION_BASE "$DBS/cpu16_floorplan_init"

if {$IS_STYLUS} {
    set SESSION_DB "${SESSION_BASE}.cui"
    write_db $SESSION_DB
} else {
    saveDesign $SESSION_BASE
    puts "INFO: Floorplan stage completed. Design saved to $SESSION_BASE"
}

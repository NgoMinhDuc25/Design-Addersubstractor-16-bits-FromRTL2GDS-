# -------------------------------------------------------------------------
# SDC File  top_addersubtractor (100 MHz)
# -------------------------------------------------------------------------

create_clock -name "clk" -period 10.0 -waveform {0.0 5.0} [get_ports p_Clock]

# For 130nm,  0.2ns - 0.5ns 
set_clock_uncertainty 0.3 [get_clocks clk]

set_input_delay -max 2.0 -clock clk [get_ports p_Reset]
set_input_delay -max 2.0 -clock clk [get_ports p_Sel]
set_input_delay -max 2.0 -clock clk [get_ports p_AddSub]
set_input_delay -max 2.0 -clock clk [get_ports p_A[*]]
set_input_delay -max 2.0 -clock clk [get_ports p_B[*]]

set_output_delay -max 2.0 -clock clk [get_ports p_Z[*]]
set_output_delay -max 2.0 -clock clk [get_ports p_Overflow]

#set_driving_cell -lib_cell sg13g2_slinv_4 -pin Y [all_inputs]

# 0.1pF (100fF)
set_load 0.1 [all_outputs]

set_false_path -from [get_ports p_Reset]

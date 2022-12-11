set_attr init_hdl_search_path {./} 
set_attr init_lib_search_path /opt/apps/cadence/software/FOUNDRY/analog/45nm/lan/flow/t1u1/reference_libs/GPDK045/gsclib045_all_v4.4/gsclib045/timing
set_attribute library {slow_vdd1v2_basicCells.lib}
set_attribute information_level 6 

set rtlFiles [list Sklansky_adder.v Bitwise_PG.v Final_sum.v Gray_cell.v Sklansky_grp_PG.v Black_cell.v]   ;# All HDL files

set basename Sklansky_adder      ;# name of top level module
set runname gates_genus            ;# name appended to output files





set frequency    100.0          ;# Clock frequency in MHz
set myClk        clk          ;# clock name
set input_setup  10           ;# delay from clock to inputs valid (in ps)
set output_delay 30            ;# delay from clock to output valid (in ps)
set clock_period [expr 1000000.0 / $frequency]   ;# Clock period in ps


#*********************************************************
#*   below here shouldn't need to be changed...          *
#*********************************************************

# Analyze and Elaborate HDL files
read_hdl -v2001 ${rtlFiles}
elaborate ${basename}


#set_drive     4.0 [all_inputs]
#set_load      6.0 [all_outputs]
#set_max_fanout 5   [all_inputs]

# set_max_area          0
# set_max_delay         8 -to [all_outputs]
# create_clock -period  2  Clock
# set_output_delay      1  [all_outputs] -clock Clock
# set_input_delay       1  [all_inputs]  -clock Clock


# Apply Constraints and generate clocks
set clock [define_clock -period ${clock_period} -name ${myClk} [clock_ports]]	
external_delay -input $input_setup -clock ${myClk} [find / -port ports_in/*]
external_delay -output $output_delay -clock ${myClk} [find / -port ports_out/*]

# dc::set_clock_transition -min 0.25 [get_clocks $myClk]
# dc::set_clock_transition -max 0.3 [get_clocks $myClk]
# dc::set_clock_latency -min 3.5 [get_clocks $myClk]
# dc::set_clock_latency -max 5.5 [get_clocks $myClk]

# check the design is OK
check_design -unresolved
report timing -lint

# Synthesize the design to the target library
# synthesize -effort medium -to_mapped
set_attribute syn_generic_effort medium
set_attribute syn_map_effort medium
set_attribute syn_opt_effort medium
syn_generic
syn_map
syn_opt

# Write out gate-level Verilog and sdc files

change_names -instance -restricted "\[ \] ." -replace_str "_" -log_changes change_names_verilog

write_hdl -mapped >  ${basename}_${runname}.v
write_sdc >  ${basename}_${runname}.sdc

write_sdf  -delimiter / -edges check_edge -no_escape -setuphold split -recrem split  > ${basename}_${runname}.sdf

# Write out the area, timing, and power reports
report timing > ${basename}_${runname}_timing.rep
report gates  > ${basename}_${runname}_area.rep
report power  > ${basename}_${runname}_power.rep

gui_show

# Uncomment the following line if you need the tool exists automatically
# exit

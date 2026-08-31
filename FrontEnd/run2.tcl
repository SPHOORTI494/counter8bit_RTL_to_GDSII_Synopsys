############################################################
# Create WORK library
############################################################

define_design_lib WORK -path ./synthesis/WORK

############################################################
# Technology Library
############################################################

set_app_var search_path \
"/home/synopsys/synopsys_tools/tech_libs/lib32nm/edk32nm/SAED32_EDK/lib/stdcell_rvt/db_nldm"

set_app_var target_library "saed32rvt_ss0p95v125c.db"

set_app_var link_library "* $target_library"

############################################################
# Read RTL
############################################################

read_verilog ./verilogFiles/counter8bit.v

current_design counter8bit

link

check_design

############################################################
# Read Constraints
############################################################

read_sdc ./constraints/counter8bit.sdc

############################################################
# Compile
############################################################

compile_ultra

############################################################
# Create output directories
############################################################

file mkdir synthesis/results
file mkdir synthesis/reports

############################################################
# Outputs
############################################################

write -format verilog \
-hierarchy \
-output synthesis/results/counter8bit_syn.v

write -format ddc \
-hierarchy \
-output synthesis/results/counter8bit.ddc

write_sdf synthesis/results/counter8bit.sdf

write_sdc -nosplit synthesis/results/counter8bit_out.sdc

############################################################
# Reports
############################################################

report_area > synthesis/reports/area.rpt

report_power > synthesis/reports/power.rpt

report_timing > synthesis/reports/timing.rpt

report_qor > synthesis/reports/qor.rpt

report_constraint -all_violators > synthesis/reports/constraint.rpt

exit

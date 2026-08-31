############################################################
# CTS - 8-bit Counter / SAED32 RVT
############################################################

puts "===================================================="
puts "              START CTS"
puts "===================================================="

############################################################
# 1. Check clock
############################################################

puts "Clock definition:"
report_clocks

############################################################
# 2. Set CTS buffer cells
#
# NBUFF cells are non-inverting buffers.
# Avoid NBUFFX1 because it was not found as a valid lib-cell.
############################################################

puts "Setting CTS buffer cells..."

set_lib_cell_purpose -exclude cts [get_lib_cells */*]
set_lib_cell_purpose -include cts \
    [get_lib_cells saed32_rvt|saed32_rvt_std/NBUFFX2_RVT]
set_lib_cell_purpose -include cts \
    [get_lib_cells saed32_rvt|saed32_rvt_std/NBUFFX4_RVT]
set_lib_cell_purpose -include cts \
    [get_lib_cells saed32_rvt|saed32_rvt_std/NBUFFX8_RVT]
set_lib_cell_purpose -include cts \
    [get_lib_cells saed32_rvt|saed32_rvt_std/NBUFFX16_RVT]
set_lib_cell_purpose -include cts \
    [get_lib_cells saed32_rvt|saed32_rvt_std/NBUFFX32_RVT]

############################################################
# 3. Clock routing
#
# Keep CTS routing above the standard-cell M1 rail.
# Use M3/M4 for the clock tree initially.
############################################################

#set_clock_routing_rules -net_type clock \
#   -min_routing_layer M3 \
 #   -max_routing_layer M4

############################################################
# 4. Run CTS + post-CTS optimization
############################################################

puts "Running clock_opt..."

clock_opt

############################################################
# 5. Check timing after CTS
############################################################

puts "===================================================="
puts "              POST-CTS QoR"
puts "===================================================="

report_qor

puts "===================================================="
puts "              CTS COMPLETED"
puts "===================================================="


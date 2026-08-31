puts "===================================================="
puts "        START POWER PLANNING"
puts "===================================================="

############################################################
# 1. Define Power and Ground Nets
############################################################

puts "Creating VDD/VSS PG nets..."

create_net -power VDD
create_net -ground VSS

puts "VDD net: [get_nets VDD]"
puts "VSS net: [get_nets VSS]"


############################################################
# 2. Standard-cell rail pattern
############################################################

puts "Creating standard-cell rail pattern..."

create_pg_std_cell_conn_pattern stdcell_rail_pattern \
    -layers {M1}


############################################################
# 3. Core ring pattern
############################################################

puts "Creating core power ring pattern..."

create_pg_ring_pattern core_ring_pattern \
    -horizontal_layer M5 \
    -vertical_layer M6 \
    -horizontal_width 2 \
    -vertical_width 2 \
    -horizontal_spacing 1 \
    -vertical_spacing 1


############################################################
# 4. Core ring strategy
############################################################

puts "Creating core PG strategy..."

set_pg_strategy core_ring_strategy \
    -core \
    -pattern {{name: core_ring_pattern} {nets: {VDD VSS}}}


############################################################
# 5. Standard-cell rail strategy
############################################################

puts "Creating standard-cell rail strategy..."

set_pg_strategy stdcell_rail_strategy \
    -core \
    -pattern {{name: stdcell_rail_pattern} {nets: {VDD VSS}}}


############################################################
# 6. Compile PG
############################################################

puts "Compiling power grid..."

compile_pg \
    -strategies {core_ring_strategy stdcell_rail_strategy}


############################################################
# 7. PG connectivity
############################################################

puts "===================================================="
puts "        CHECKING PG CONNECTIVITY"
puts "===================================================="

check_pg_connectivity


############################################################
# 8. PG DRC
############################################################

puts "===================================================="
puts "        CHECKING PG DRC"
puts "===================================================="

check_pg_drc


############################################################
# 9. Save
############################################################

save_block -as power_planning_finished

puts "===================================================="
puts "        POWER PLANNING COMPLETED"
puts "===================================================="





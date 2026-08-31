
# ----------------------------------------------------------
# 1. Initialize Floorplan
# ----------------------------------------------------------
initialize_floorplan \
    -side_ratio 1.0 \
    -core_utilization 0.5 \
    -core_offset 20 \
    -site unit

# ----------------------------------------------------------
# 2. PG Logical Setup
# ----------------------------------------------------------
create_net -power VDD
create_net -ground VSS

set_attribute [get_nets VDD] net_type power
set_attribute [get_nets VSS] net_type ground

# ----------------------------------------------------------
# 3. Standard Cell Power Rails
# ----------------------------------------------------------
create_pg_std_cell_conn_pattern rail_pattern

set_pg_strategy rail_strat \
    -core \
    -pattern {{name: rail_pattern} {nets: {VDD VSS}}}

compile_pg -strategies rail_strat

# ----------------------------------------------------------
# 4. Power Ring
# ----------------------------------------------------------
create_pg_ring_pattern ring_pt \
    -horizontal_layer M3 \
    -horizontal_width 2 \
    -horizontal_spacing 1 \
    -vertical_layer M2 \
    -vertical_width 2 \
    -vertical_spacing 1

set_pg_strategy ring_strat \
    -core \
    -pattern {{name: ring_pt} {nets: {VDD VSS}}}

compile_pg -strategies ring_strat

save_block -as floorplan_finished

Icc2_shell > connect_pg_net -net VDD [get_pins -hierarchical */VDD]
connect_pg_net -net VSS [get_pins -hierarchical */VSS]
compile_pg -strategies rail_strat

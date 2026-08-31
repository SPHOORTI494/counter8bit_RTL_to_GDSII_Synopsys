############################################################
# ICC2 Step 3: Pin Placement - 8-bit Counter
############################################################

puts "=================================================="
puts "STARTING PIN PLACEMENT"
puts "=================================================="

puts "Current Library: [current_lib]"
puts "Current Block:  [current_block]"

############################################################
# 1. Constrain input pins to LEFT side
#    Side 1 = LEFT
############################################################

set_individual_pin_constraints \
    -ports [get_ports {clk reset}] \
    -allowed_layers {M3} \
    -sides {1} \
    -pin_spacing_distance 2.0

############################################################
# 2. Constrain output pins to RIGHT side
#    Side 3 = RIGHT
############################################################

set_individual_pin_constraints \
    -ports [get_ports {count[7] count[6] count[5] count[4] \
                       count[3] count[2] count[1] count[0]}] \
    -allowed_layers {M3} \
    -sides {3} \
    -pin_spacing_distance 2.0

############################################################
# 3. Place pins
############################################################

place_pins -ports [get_ports *]

############################################################
# 4. Legalize pin placement
############################################################

place_pins -ports [get_ports *] -legalize

############################################################
# 5. Save checkpoint
############################################################

save_block -as pin_placement_finished

puts "=================================================="
puts "PIN PLACEMENT COMPLETED"
puts "=================================================="





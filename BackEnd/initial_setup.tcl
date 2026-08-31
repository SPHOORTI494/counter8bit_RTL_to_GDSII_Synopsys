############################################################
# ICC2 Initial Setup - 8-bit Counter
############################################################

set DESIGN_NAME "counter8bit_lib"

set TECH_FILE \
"/home/synopsys/synopsys_tools/tech_libs/lib32nm/edk32nm/SAED32_EDK/tech/milkyway/saed32nm_1p9m_mw.tf"

set REF_LIB \
"/home/synopsys/synopsys_tools/CLIBs/saed32_rvt.ndm"

set NETLIST \
"/home/synopsys/Sphoorti/synthesis/results/counter8bit_syn.v"

set SDC \
"/home/synopsys/Sphoorti/synthesis/results/counter8bit_out.sdc"

set TLUPLUS \
"/home/synopsys/synopsys_tools/tech_libs/lib32nm/edk32nm/SAED32_EDK/tech/star_rcxt/saed32nm_1p9m_nominal.tluplus"


############################################################
# 1. Create design library
############################################################

if {[file exists $DESIGN_NAME]} {
    file delete -force $DESIGN_NAME
}

create_lib $DESIGN_NAME \
    -technology $TECH_FILE \
    -ref_libs $REF_LIB

current_lib $DESIGN_NAME


############################################################
# 2. Read synthesized netlist
############################################################

read_verilog $NETLIST

link_block


############################################################
# 3. Read timing constraints
############################################################

read_sdc $SDC


############################################################
# 4. RC / TLUPlus setup
############################################################

read_parasitic_tech \
    -tlup $TLUPLUS \
    -name nominal_rc

set_parasitic_parameters \
    -early_spec nominal_rc \
    -late_spec nominal_rc


############################################################
# 5. Basic reports
############################################################

report_clocks
report_design

puts "=================================================="
puts "ICC2 INITIAL SETUP COMPLETED"
puts "=================================================="





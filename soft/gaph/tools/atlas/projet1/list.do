onerror {resume}

add list -dec -width 46 -label R_0000_EAST  /topnoc/noc/monitor_router0000/reg_east_Q
add list -dec -width 46 -label R_0000_NORTH  /topnoc/noc/monitor_router0000/reg_north_Q
add list -dec -width 46 -label R_0000_LOCAL  /topnoc/noc/monitor_router0000/reg_local_Q
add list -dec -width 46 -label R_0100_EAST  /topnoc/noc/monitor_router0100/reg_east_Q
add list -dec -width 46 -label R_0100_WEST  /topnoc/noc/monitor_router0100/reg_west_Q
add list -dec -width 46 -label R_0100_NORTH  /topnoc/noc/monitor_router0100/reg_north_Q
add list -dec -width 46 -label R_0100_LOCAL  /topnoc/noc/monitor_router0100/reg_local_Q
add list -dec -width 46 -label R_0200_WEST  /topnoc/noc/monitor_router0200/reg_west_Q
add list -dec -width 46 -label R_0200_NORTH  /topnoc/noc/monitor_router0200/reg_north_Q
add list -dec -width 46 -label R_0200_LOCAL  /topnoc/noc/monitor_router0200/reg_local_Q
add list -dec -width 46 -label R_0001_EAST  /topnoc/noc/monitor_router0001/reg_east_Q
add list -dec -width 46 -label R_0001_NORTH  /topnoc/noc/monitor_router0001/reg_north_Q
add list -dec -width 46 -label R_0001_SOUTH  /topnoc/noc/monitor_router0001/reg_south_Q
add list -dec -width 46 -label R_0001_LOCAL  /topnoc/noc/monitor_router0001/reg_local_Q
add list -dec -width 46 -label R_0101_EAST  /topnoc/noc/monitor_router0101/reg_east_Q
add list -dec -width 46 -label R_0101_WEST  /topnoc/noc/monitor_router0101/reg_west_Q
add list -dec -width 46 -label R_0101_NORTH  /topnoc/noc/monitor_router0101/reg_north_Q
add list -dec -width 46 -label R_0101_SOUTH  /topnoc/noc/monitor_router0101/reg_south_Q
add list -dec -width 46 -label R_0101_LOCAL  /topnoc/noc/monitor_router0101/reg_local_Q
add list -dec -width 46 -label R_0201_WEST  /topnoc/noc/monitor_router0201/reg_west_Q
add list -dec -width 46 -label R_0201_NORTH  /topnoc/noc/monitor_router0201/reg_north_Q
add list -dec -width 46 -label R_0201_SOUTH  /topnoc/noc/monitor_router0201/reg_south_Q
add list -dec -width 46 -label R_0201_LOCAL  /topnoc/noc/monitor_router0201/reg_local_Q
add list -dec -width 46 -label R_0002_EAST  /topnoc/noc/monitor_router0002/reg_east_Q
add list -dec -width 46 -label R_0002_SOUTH  /topnoc/noc/monitor_router0002/reg_south_Q
add list -dec -width 46 -label R_0002_LOCAL  /topnoc/noc/monitor_router0002/reg_local_Q
add list -dec -width 46 -label R_0102_EAST  /topnoc/noc/monitor_router0102/reg_east_Q
add list -dec -width 46 -label R_0102_WEST  /topnoc/noc/monitor_router0102/reg_west_Q
add list -dec -width 46 -label R_0102_SOUTH  /topnoc/noc/monitor_router0102/reg_south_Q
add list -dec -width 46 -label R_0102_LOCAL  /topnoc/noc/monitor_router0102/reg_local_Q
add list -dec -width 46 -label R_0202_WEST  /topnoc/noc/monitor_router0202/reg_west_Q
add list -dec -width 46 -label R_0202_SOUTH  /topnoc/noc/monitor_router0202/reg_south_Q
add list -dec -width 46 -label R_0202_LOCAL  /topnoc/noc/monitor_router0202/reg_local_Q


configure list -usestrobe 1

#Abaixo o strobeperiod depende do numero de janelas e do periodo do clock. Strobeperiod = (janelas+1)*periodo
configure list -strobestart {0 ps} -strobeperiod {20020ns}
configure list -usesignaltrigger 0
configure list -delta none
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5


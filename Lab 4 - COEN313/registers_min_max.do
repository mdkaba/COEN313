add wave din

add wave reset
add wave clk
add wave sel
add wave max_out
add wave min_out
add wave reg_out
add wave R0
add wave R1
add wave R2
add wave R3

force din 0101
force reset 1
force clk 0
force sel 01
run 2

force reset 0
force clk 1
force sel 00
run 2

force din 1001
force clk 0
run 2

force clk 1
force sel 01
run 2

force din 1011
force clk 0
run 2

force clk 1
force sel 10
run 2

force din 0001
force clk 0
run 2

force clk 1
force sel 11
run 2

force din 1101
force clk 0
run 2

force clk 1
force sel 10
r

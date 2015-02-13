onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /afifo_ptr_tb/PTR_0/rst
add wave -noupdate /afifo_ptr_tb/PTR_0/clk
add wave -noupdate /afifo_ptr_tb/PTR_0/clk_en
add wave -noupdate -radix hexadecimal /afifo_ptr_tb/PTR_0/ptr
add wave -noupdate -radix hexadecimal /afifo_ptr_tb/PTR_0/addr
add wave -noupdate /afifo_ptr_tb/PTR_0/gray_aux
add wave -noupdate -radix binary /afifo_ptr_tb/PTR_0/gray_i
add wave -noupdate /afifo_ptr_tb/PTR_0/addr_h
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 98
configure wave -valuecolwidth 50
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 8000
configure wave -griddelta 25
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {22340 ps}

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ci_control_tb/cam_reset
add wave -noupdate /ci_control_tb/CI_CTRL_0/clk
add wave -noupdate /ci_control_tb/CI_CTRL_0/rst
add wave -noupdate -expand -group {CAM Control} /ci_control_tb/CI_CTRL_0/soft_reset
add wave -noupdate -expand -group {CAM Control} /ci_control_tb/CI_CTRL_0/stschg_ack
add wave -noupdate -expand -group {CAM Control} /ci_control_tb/CI_CTRL_0/ci_timeout
add wave -noupdate -expand -group {CAM Interface} /ci_control_tb/CI_CTRL_0/ci_cd_n
add wave -noupdate -expand -group {CAM Interface} /ci_control_tb/CI_CTRL_0/ci_reset
add wave -noupdate -expand -group {CAM Interface} /ci_control_tb/CI_CTRL_0/ci_reset_oe_n
add wave -noupdate -expand -group {CAM Interface} /ci_control_tb/CI_CTRL_0/ci_overcurrent_n
add wave -noupdate -expand -group {CAM Interface} /ci_control_tb/CI_CTRL_0/ci_ireq_n
add wave -noupdate -expand -group {CAM Status} /ci_control_tb/CI_CTRL_0/cam_stschg
add wave -noupdate -expand -group {CAM Status} /ci_control_tb/CI_CTRL_0/cam_present
add wave -noupdate -expand -group {CAM Status} /ci_control_tb/CI_CTRL_0/cam_reset
add wave -noupdate -expand -group {CAM Status} /ci_control_tb/CI_CTRL_0/cam_ready
add wave -noupdate -expand -group {CAM Status} /ci_control_tb/CI_CTRL_0/cam_error
add wave -noupdate -expand -group {CAM Status} /ci_control_tb/CI_CTRL_0/cam_ovcp
add wave -noupdate -expand -group {CAM Status} /ci_control_tb/CI_CTRL_0/cam_busy
add wave -noupdate -expand -group {CAM Status} /ci_control_tb/CI_CTRL_0/cam_interrupt
add wave -noupdate /ci_control_tb/CI_CTRL_0/ci_cd
add wave -noupdate /ci_control_tb/CI_CTRL_0/ci_ovcp_sync
add wave -noupdate /ci_control_tb/CI_CTRL_0/ci_ireq_sync
add wave -noupdate /ci_control_tb/CI_CTRL_0/ci_stschg
add wave -noupdate /ci_control_tb/CI_CTRL_0/end_of_por
add wave -noupdate /ci_control_tb/CI_CTRL_0/end_of_reset
add wave -noupdate /ci_control_tb/CI_CTRL_0/end_of_tsu
add wave -noupdate -radix unsigned /ci_control_tb/CI_CTRL_0/ci_cnt
add wave -noupdate /ci_control_tb/CI_CTRL_0/ci_reset_oe_i
add wave -noupdate /ci_control_tb/CI_CTRL_0/ci_reset_n
add wave -noupdate /ci_control_tb/CI_CTRL_0/ci_reset_phase_n
add wave -noupdate /ci_control_tb/CI_CTRL_0/ci_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {326521854 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 134
configure wave -valuecolwidth 74
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
WaveRestoreZoom {0 ps} {525 us}

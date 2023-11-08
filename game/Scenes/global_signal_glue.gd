class_name SignalGlue
extends Node

"""
 Used for global signals
"""

# Monkey Signals
signal is_monkey_action_pressed
signal is_monkey_action_not_pressed

# Nuclear Core 
signal animate_select_nuclear_core
signal nuclear_core_needs_cooling
signal nuclear_core_broken
signal nuclear_core_clicked(core_position: Vector2)
signal nuclear_core_action_started
signal nuclear_core_action_stopped

# Control Panel
signal animate_select_control_panel

# Nuclear Waste
extends Node2D


# Collision Layer Constants
# NUCLEAR_CORE_LAYER: 	Layer 2, 	Bit 2
# NUCLEAR_WATES_LAYER: 	Layer 3, 	Bit 4
# CONTROL_PANEL: 		Layer 4, 	Bit 8
enum C_LAYER {
	NUCLEAR_CORE_LAYER = 2,		
	NUCLEAR_WASTE_LAYER = 4,	
	CONTROL_PANEL = 8
}


# Function Name: check_machine_collision
# Description:
# 	Check if the monkey has collided with any of the machines and start the actions
func check_machine_collisions(collision_info) -> void:
	if collision_info:
		var collider = collision_info.get_collider()
		if collider.is_in_group("MachineGroup"):
			
			# Nuclear Core Collision
			if collider.collision_layer == C_LAYER.NUCLEAR_CORE_LAYER:
				if get_parent().monkey_action_state == MonkeyState.M_STATES.DO_ACTION:
					$"../MonkeyDoAction".start_nuclear_action(collider)
					
			# Nuclear Waste Collision
			if collider.collision_layer == C_LAYER.NUCLEAR_WASTE_LAYER:
				pass

			# Control Panel Collision
			if collider.collision_layer == C_LAYER.CONTROL_PANEL:
				pass



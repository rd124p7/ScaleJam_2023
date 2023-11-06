extends Node2D

# Collision Layer Constants
enum C_LAYER {
	NUCLEAR_CORE_LAYER = 2,
	NUCLEAR_WASTE_LAYER = 3,
	CONTROL_PANEL = 4
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
				pass
			
			# Nuclear Waste Collision
			if collider.collision_layer == C_LAYER.NUCLEAR_WASTE_LAYER:
				pass

			# Control Panel Collision
			if collider.collision_layer == C_LAYER.CONTROL_PANEL:
				pass



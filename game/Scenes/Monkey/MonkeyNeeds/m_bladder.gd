class_name M_Bladder
extends Node2D

# Property Name: current_bladder_amount
# Description:
#	
var current_bladder_amount: float = 0:
	set(value):
		current_bladder_amount = clamp(value, 0, 100)
	get:
		return current_bladder_amount



extends Control


# Function Name: _on_tree_exited
# Description:
# 	When the node is removed from the tree, free the object from memory
func _on_tree_exited():
	self.queue_free()


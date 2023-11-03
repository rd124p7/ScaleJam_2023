extends Control


func _ready():
	pass


func _process(_delta):
	pass


func _on_tree_exited():
	self.queue_free()


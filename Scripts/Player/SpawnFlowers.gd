extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var flower_object = load("res://Scenes/Flowers/Flower.tscn")

		
func _physics_process(delta):
	if not $FlowerRaycast.is_colliding() and get_parent().is_on_floor():
		if $GroundRaycast.is_colliding():
			print($GroundRaycast.get_collider())
			var inst = flower_object.instance()
			get_tree().get_root().add_child(inst)
			inst.add_to_group("flowers")
			inst.global_position = self.global_position

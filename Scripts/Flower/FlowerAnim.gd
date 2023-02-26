extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("grow")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if($GroundRaycast.is_colliding()):
		var collision = $GroundRaycast.get_collider()
		if not collision is TileMap:
			queue_free()
		else:
			if(collision.has_method("is_converted")):
				if collision.is_converted(collision.position):
					queue_free()

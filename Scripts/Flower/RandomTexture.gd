extends Node


export (Array, Texture) var textures = []


# Called when the node enters the scene tree for the first time.
func _ready():
	self.texture = textures[randi() % textures.size()]



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

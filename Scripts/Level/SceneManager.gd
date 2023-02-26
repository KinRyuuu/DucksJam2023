extends Node

var current_scene = null
var scene_number = 1

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func change_scene(path: String):
	# 1. It is now safe to remove the current scene
	current_scene.queue_free()

	# 2. Load the new scene.
	var new_scene = ResourceLoader.load(path)

	# 3. Instance the new scene.
	current_scene = new_scene.instance()

	# 4. Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible 
	# with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)



func _on_Growable_level_complete():
	scene_number += 1
	change_scene("res://Scenes/Levels/Level"+str(scene_number))

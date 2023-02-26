extends Node2D

func changed_health(health):
	if health <= 0:
		get_tree().change_scene("res://Scenes/Levels/GameOver.tscn")
		print("GAME OVER");
		# Do game over stuff here

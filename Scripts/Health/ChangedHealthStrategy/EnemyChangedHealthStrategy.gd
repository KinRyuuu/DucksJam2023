extends Node2D

signal die();

func changed_health(health):
	if health <= 0:
		emit_signal("die");

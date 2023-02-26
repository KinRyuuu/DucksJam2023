extends Node2D

export var max_hp = 100;
export var start_hp = 100;
export (Array, String) var damage_groups = ["enemy"]
onready var hp = start_hp;
var can_take_damage = true;
var iframe_timer = 0.01; # How long to become invincible after taking damage

signal took_damage(damage)

func take_damage(damage, hit_position=global_position):
	if(can_take_damage):
		hp -= damage;
		if(get_node_or_null("ChangedHealthStrategy") != null):
			$ChangedHealthStrategy.changed_health(hp);
		if(get_node_or_null("IFrameTimer") != null):
			can_take_damage = false;
			$IFrameTimer.wait_time = iframe_timer;
			$IFrameTimer.start();
		
		emit_signal("took_damage", damage)

func _on_Hitbox_area_entered(area):
	var member_groups = area.get_groups()
	for group in member_groups:
		if group in damage_groups:
			if area.has_method("get_damage"):
				take_damage(area.get_damage())
				area.queue_free();
			break;

func _on_IFrameTimer_timeout():
	can_take_damage = true;

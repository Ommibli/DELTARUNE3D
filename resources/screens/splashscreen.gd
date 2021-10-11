extends Node2D


func _ready():
	$AnimationPlayer.play("fadeout")


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://resources/zones/dw1.tscn")

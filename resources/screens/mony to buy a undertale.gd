extends Node2D


func _ready():
	pass


func _on_VideoPlayer_finished():
	$VideoPlayer.play()

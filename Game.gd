extends Node2D

# Flag de restart.
var restart = false

func _physics_process(delta):
	# Reinicia a cena.
	if restart:
		if Input.is_action_just_pressed("restart"):
			get_tree().change_scene("res://Game.tscn")

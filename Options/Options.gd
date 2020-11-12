extends ColorRect

func _on_ExitButton_mouse_entered():
	$ExitButton.modulate.a = 1.5

func _on_ExitButton_mouse_exited():
	$ExitButton.modulate.a = 1

func _on_EfeitoSonoro_toggled(button_pressed):
	if button_pressed:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -80)

func _on_ExitButton_pressed():
	get_tree().change_scene("res://Main.tscn")

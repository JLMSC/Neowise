extends StaticBody2D

# Toca "ExpandEffect" quando carregado.
func _ready():
	$AnimationPlayer.play("ExpandEffect")

# Aumenta a opacidade do botão quando o mouse está em cima.
func _on_ExitButton_mouse_entered():
	$ExitButton.modulate.a = 1.5

# Diminui a opacidade do botão quando o mouse não está em cima.
func _on_ExitButton_mouse_exited():
	$ExitButton.modulate.a = 1

# Aumenta a opacidade do botão quando o mouse está em cima.
func _on_OptionsButton_mouse_entered():
	$OptionsButton.modulate.a = 1.5

# Diminui a opacidade do botão quando o mouse não está em cima.
func _on_OptionsButton_mouse_exited():
	$OptionsButton.modulate.a = 1

# Volta para o Menu quando ExitButton for pressionado.
func _on_ExitButton_pressed():
	get_tree().change_scene("res://Main.tscn")

extends Control

# Quando carregado, conecta o Socket e executa a animação de FadeIn.
func _ready():
	#Socket.connect_to_server()
	$AnimationPlayer.play("MenuFadeIn")
	
# Troca para a cena "Game" quando o botão "PlayButton" é pressionado.
func _on_PlayButton_pressed():
	get_tree().change_scene("res://Game.tscn")

# Aumenta a opacidade do botão quando o mouse está em cima.
func _on_PlayButton_mouse_entered():
	$PlayButton.modulate.a = 1.5

# Diminui a opacidade do botão quando o mouse não está em cima.
func _on_PlayButton_mouse_exited():
	$PlayButton.modulate.a = 1

# Mostra a tela de opção quando o botão "OptionsButton" é pressionado.
func _on_OptionsButton_pressed():
	get_tree().change_scene("res://Options/Options.tscn")

# Aumenta a opacidade do botão quando o mouse está em cima.
func _on_OptionsButton_mouse_entered():
	$OptionsButton.modulate.a = 1.5

# Diminui a opacidade do botão quando o mouse não está em cima.
func _on_OptionsButton_mouse_exited():
	$OptionsButton.modulate.a = 1

# Fecha a aplicação quando o botão "ExitButton" é pressionado.
func _on_ExitButton_pressed():
	get_tree().quit()

# Aumenta a opacidade do botão quando o mouse está em cima.
func _on_ExitButton_mouse_entered():
	$ExitButton.modulate.a = 1.5

# Diminui a opacidade do botão quando o mouse não está em cima.
func _on_ExitButton_mouse_exited():
	$ExitButton.modulate.a = 1

# Deixa o "FadeInObject" invisível quando a animação termina de tocar.
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "MenuFadeIn":
		$FadeInObject.visible = false

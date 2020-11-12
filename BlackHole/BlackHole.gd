extends KinematicBody2D

# Desabilita o colisor para tocar a animação.
func _ready():
	$CollisionShape2D.disabled = true

# Habilita o colisor quando a animação termina.
func _on_GameStartAnimation_animation_finished(anim_name):
	if anim_name == "BlackHolePlayerMoveAnimation":
		$CollisionShape2D.disabled = false

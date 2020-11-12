extends KinematicBody2D

# Velocidade e direção da bala.
var speed = 300
var direction = Vector2()

# Collisor player.
var player = null

func _physics_process(delta):
	# Move a bala verticalmente.
	direction.y += speed
	move_and_slide(direction)
	
	# Verifica os colisores.
	if get_slide_count():
		var collider = get_slide_collision(get_slide_count() - 1).collider
		
		# Se a condição for verdadeira, player é destruido de root.
		if "player" in collider.get_groups():
			player = get_tree().get_nodes_in_group("player")
			player[0].get_node("AnimatedSprite").play("death")
			
		# Destroi a bala sempre que houver colisão.
		queue_free()

	# Reseta a direção e deixa o movimento suave.
	direction.y = 0

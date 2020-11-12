extends KinematicBody2D

# Velocidade e direção da bala.
var speed = 300
var direction = Vector2()

# Inimigo que a bala atingiu.
var enemy = null

func _physics_process(delta):
	# Move verticalmente.
	direction.y -= speed
	move_and_slide(direction)
	
	# Verifica os colisores.
	if get_slide_count():
		var collider = get_slide_collision(get_slide_count() - 1).collider
		
		# Verifica os colisores de "collider".
		if "tank" in collider.get_groups():
			enemy = get_tree().get_nodes_in_group("tank")
		elif "blast" in collider.get_groups():
			enemy = get_tree().get_nodes_in_group("blast")
		elif "fast" in collider.get_groups():
			enemy = get_tree().get_nodes_in_group("fast")

		# Toca a animação de morte do inimigo se a condição for satisfeita.
		if enemy:
			collider.get_node("AnimatedSprite").play("death")
			# Toca o som de morte.
			collider.get_node("DeathSound").play()
			
			get_parent().get_node("Player").kills += 1
			
			# Altera o contador sempre que um inimigo é destruido.
			var new_value = get_parent().get_node("Player").kills_target - get_parent().get_node("Player").kills
			get_parent().get_node("InGameBackground/Missao").text = str(new_value)
		
		# Destroi a bala se colidir com qualquer coisa.
		queue_free()
	
	# Reseta o valor de direction, deixando a movimentação suave.
	direction.y = 0

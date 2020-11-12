extends KinematicBody2D

# Clock -> Tempo limite.
var clock = 3
# Time -> Tempo decorrido.
var time = 0

# Limites da tela.
var left_side = 20
var right_side = 510
var flag = true

# Toca a animação default quando a cena é carregada.
func _ready():
	$AnimatedSprite.play("default")

func _physics_process(delta):
	# Desce o Fast em 0.5px a cada frame.
	$".".position.y += 0.5
	
	# Move o Fast no eixo X de acordo com o valor da flag.
	if flag:
		$".".position.x -= 3
	else:
		$".".position.x += 3
		
	# Muda o sentido caso o Fast chegue nos limites da tela.
	if $".".position.x >= right_side:
		flag = true
	if $".".position.x <= left_side:
		flag = false
		
	# Destroi o inimigo se ele sair da tela.
	if $".".position.y >= 600:
		queue_free()
	
	# Aumenta o tempo decorrido.
	time += delta
	
	# Quando o tempo decorrido for maior que o tempo limite.
	if time > clock:
		# Carrega a cena da bala.
		var bullet = load("res://Enemies/Fast/Bullet/FastBullet.tscn").instance()
		
		# Pega a posição do Fast.
		var position_x = $AnimatedSprite.get_parent().position[0]
		var position_y = $AnimatedSprite.get_parent().position[1]
		
		# Ajusta a posição da bala ao Fast.
		bullet.global_position[0] = position_x
		bullet.global_position[1] = position_y + 40
		
		# Adiciona ao root.
		get_parent().add_child(bullet)
		
		# Toca o som Shoot e reseta o valor do tempo decorrido.
		$ShootSound.play()
		time = 0

# Deixa Fast invisível quando a animação de morte termina.
func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "death":
		$AnimatedSprite.visible = false
		$CollisionShape2D.disabled = true

# Destroi quando o som Death termina.
func _on_DeathSound_finished():
	$AnimatedSprite.get_parent().queue_free()

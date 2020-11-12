extends KinematicBody2D

# Speed -> Velocidade em pixels do jogador.
var speed = 250
# Direction -> Direção em que o jogador vai se mover.
var direction = Vector2()

# Black_Hole -> Cena do buraco negro.
var black_hole = load("res://BlackHole/BlackHole.tscn").instance()
# Gravity -> Força de atração do buraco negro.
var gravity = 100

# Flag que não permite que o jogador atira inúmeras vezes.
var canShoot = false

# Kills -> Quantidade de inimigos mortos.
var kills = 0

# Level -> Nível atual do jogo.
var level = 0

# Kills_target -> Quantidade de inimigos para matar.
var kills_target = 3

# Cena dos inimigos.
var blast = load("res://Enemies/Blast/Blast.tscn")
var fast = load("res://Enemies/Fast/Fast.tscn")
var tank = load("res://Enemies/Tank/Tank.tscn")

# Toca a animação "default" e conecta os Socket quando carregado.
func _ready():
	$AnimatedSprite.play("default")
	randomize()
	#Socket.connect("sobe", self, "onSobe")
	#Socket.connect("desce", self, "onDesce")
	#Socket.connect("esquerda", self, "onEsquerda")
	#Socket.connect("direita", self, "onDireita")
	#Socket.connect("attack", self, "onAttack")

func _physics_process(delta):	
	# Chama por level sempre que jogador passar do objetivo.
	if kills >= kills_target:
		level()
	
	# Se canShoot for true ou "shoot" for pressionado, "Bullet" é instanciado.
	if Input.is_action_just_pressed("shoot") or canShoot:
		var bullet = load("res://Player/Bullet/PlayerBullet.tscn").instance()
		
		# Pega a posição de player.
		var position_x = $AnimatedSprite.get_parent().position[0]
		var position_y = $AnimatedSprite.get_parent().position[1]
	
		# Ajusta a posição de bullet baseado na posição do jogador.
		bullet.global_position[0] = position_x
		bullet.global_position[1] = position_y - 45
		
		# Adiciona bullet ao root.
		get_parent().add_child(bullet)
		
		# Toca o som de tiro e reseta o valor da flag.
		$ShootSound.play()
		canShoot = false
		
	# Horizontal_axis -> Direção, no eixo X, do jogador.
	var horizontal_axis = Input.get_action_strength("left") - Input.get_action_strength("right")
	if horizontal_axis != 0:
		direction.x = horizontal_axis * speed
	else:
		direction.x = -gravity if position.x > black_hole.position.x else gravity

	# Vertical_axis -> Direção, no eixo Y, do jogador.
	var vertical_axis = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction.y = vertical_axis * speed if vertical_axis != 0 else gravity
		
	# Move o jogador na direção "direction" e reseta o valor de "direction".
	move_and_slide(direction)
	direction = Vector2(0, 0)
	
	# Verifica os colisores.
	if get_slide_count():
		var collider = get_slide_collision(get_slide_count() - 1).collider
		
		# Remove player de root se a condição for verdadeira.
		if "bullet" in collider.get_groups() or "blackhole" in collider.get_groups():
			$AnimatedSprite.play("death")

# Toca o som de morte e oculta o AnimatedSprite quando a animaão "death" termina.
func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "death":
		get_parent().restart = true
		$DeathSound.play()
		$AnimatedSprite.visible = false
		get_parent().get_node("DeathTitle").visible = true

# Remove player de root quando o "death" termina.
func _on_DeathSound_finished():
	$AnimatedSprite.get_parent().queue_free()

func level():
	level += 1
	get_parent().get_node("InGameBackground/Level").text = str(level)
	
	kills_target += level
	get_parent().get_node("InGameBackground/Missao").text = str(kills_target)
	
	# Itera sobre a quantidade de mortes necessárias, gera novos monstros.
	for i in range(1, kills_target + 1):
		var enemy_to_spawn = null
		var enemy_type = randi() % 3 + 1
		
		# Instanceia a cena de acordo com o valor de "enemy_type".
		if enemy_type == 1:
			enemy_to_spawn = blast.instance()
		elif enemy_type == 2:
			enemy_to_spawn = fast.instance()
		elif enemy_type == 3:
			enemy_to_spawn = tank.instance()
		
		# Adiciona a cena instanciada ao parent.
		get_parent().add_child(enemy_to_spawn)
		
		# Ajusta a posição da cena instanciada.
		enemy_to_spawn.global_position.x = randi() % 450 + 150
		enemy_to_spawn.global_position.y = 30
	kills = 0
	
	# Gera asteroids em posições aleatórias.
	for i in range(1, level + 1 if level <= 4 else 4):
		var asteroid = load("res://Asteroids/Asteroid.tscn").instance()
		
		# Adiciona a cena instanciada ao parent.
		get_parent().add_child(asteroid)
		
		# Ajusta a posição da cena instanciada.
		asteroid.global_position.x = randi() % 400 + 150
		asteroid.global_position.y = -10

#func onSobe(player):
#	print("chamando função de subir")
#	vertical_axis = -1
#
#func onDesce(player):
#	print("chamando função de descer")
#	vertical_axis = 1
#
#func onEsquerda(player):
#	print("chamando função de esquerda")
#	horizontal_axis = -1
#
#func onDireita(player):
#	print("chamando função de direita")
#	horizontal_axis = 1
#
#func onAttack(player):
#	print("chamando função de atack")
#	if time > clock:
#		canShoot = true
#		time = 0

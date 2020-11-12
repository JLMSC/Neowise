extends KinematicBody2D

# Imagens do asteroids.
var asteroids = [
	load("res://Asteroids/Asteroid_assets/asteroid_1.png"),
	load("res://Asteroids/Asteroid_assets/asteroid_2.png"),
	load("res://Asteroids/Asteroid_assets/asteroid_3.png"),
	load("res://Asteroids/Asteroid_assets/asteroid_4.png")
]

# Flag de movimento.
var canMove = false

# Velocidade e direção do asteroid.
var speed = 0

# Escolhe uma imagem aleatória pro asteroid.
func _ready():
	randomize()
	$Sprite.texture = asteroids[randi() % asteroids.size()]
	
	# Altera o valor da flag.
	canMove = true
	
	# Gera um tamanho aleatório pro asteroid.
	var scale_size = randi() % 7 + 3
	scale.x = scale_size
	scale.y = scale_size
	
	# Gera uma velocidade aleatória pro asteroid.
	speed = randi() % 1 + 6
	
func _physics_process(delta):
	# Desce, verticalmente, o asteroid.
	if canMove:
		position.y += speed
		rotation_degrees += 1

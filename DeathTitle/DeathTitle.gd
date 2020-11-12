extends Sprite

# Clock -> Tempo limite.
var clock = 0.1
# Time -> Tempo decorrido.
var time = 0

# Deixa o sprite invisível quando carregado.
func _ready():
	visible = false
	modulate.a = 0

func _physics_process(delta):
	# Aumenta o valor de time quando o sprite estiver visível.
	if visible == true:
		time += delta
		
		# Se o tempo decorrido passa o tempo limite, aumenta a opacidade em 0.3 até 1.
		if time > clock:
			if modulate.a != 1:
				modulate.a += 0.3
			time = 0

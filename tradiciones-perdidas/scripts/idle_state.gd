extends State

func enter() -> void:
	# Reproducir animación de estar quieto
	player.animation_player.play("idle")
	player.velocity.x = 0

func physics_update(delta: float) -> void:
	# Aplicar gravedad
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta
		player.move_and_slide()
		return

	var direction := Input.get_axis("move_left", "move_right")
	if direction != 0:
		transitioned.emit(self, "run")
	
	if Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "jump")
		
	# Si apretamos para abajo y estamos tocando el piso...
	if Input.is_action_pressed("move_down") and player.is_on_floor():
		transitioned.emit(self, "crouch")
		return # Cortamos la ejecución para que no haga nada más

extends State

func enter() -> void:
	# player.animation_player.play("jump")
	
	# ¡MAGIA ACÁ! Solo aplicamos el impulso del salto si venimos del suelo.
	# Esto evita que hagamos un salto en el aire si nos "desagachamos" a mitad del vuelo.
	if player.is_on_floor():
		player.velocity.y = player.jump_velocity

func physics_update(delta: float) -> void:
	# 1. Aplicar gravedad
	player.velocity.y += player.gravity * delta
	
	# 2. Permitir movimiento horizontal en el aire y voltear el sprite
	var direction := Input.get_axis("move_left", "move_right")
	if direction != 0:
		player.velocity.x = direction * player.speed
		if direction < 0:
			player.sprite.flip_h = true
		elif direction > 0:
			player.sprite.flip_h = false
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed)

	player.move_and_slide()

	# 3. ¡LA NUEVA REGLA! Si en el aire apretamos abajo, pasamos al estado agachado
	if Input.is_action_pressed("move_down"):
		transitioned.emit(self, "crouch")
		return # Cortamos acá para que el estado de salto no siga decidiendo cosas

	# 4. Si tocamos el suelo, decidimos a qué estado volver
	if player.is_on_floor():
		if direction != 0:
			transitioned.emit(self, "run")
		else:
			transitioned.emit(self, "idle")

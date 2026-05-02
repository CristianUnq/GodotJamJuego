extends State

func enter() -> void:
	player.velocity.y = player.jump_velocity

func physics_update(delta: float) -> void:
	# Aplicar gravedad
	player.velocity.y += player.gravity * delta
	
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

	# Si tocamos el suelo, decidimos a qué estado volver
	if player.is_on_floor():
		if direction != 0:
			transitioned.emit(self, "run")
		else:
			transitioned.emit(self, "idle")

extends State

func enter() -> void:
	player.animation_player.play("walk")
	pass

func physics_update(delta: float) -> void:
	# Gravedad
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta

	var direction := Input.get_axis("move_left", "move_right")
	
	if direction != 0:
		player.velocity.x = direction * player.speed
		
		if direction < 0:
			player.sprite.flip_h = true
		elif direction > 0:
			player.sprite.flip_h = false
	else:
		# Si soltaron la tecla, volvemos a Idle
		transitioned.emit(self, "idle")

	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		transitioned.emit(self, "jump")
		
	# Si apretamos para abajo y estamos tocando el piso...
	if Input.is_action_pressed("move_down") and player.is_on_floor():
		transitioned.emit(self, "crouch")
		return # Cortamos la ejecución para que no haga nada más

	player.move_and_slide()

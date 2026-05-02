extends State

func enter() -> void:
	# Nos hacemos chiquitos
	player.standing_collision.set_deferred("disabled", true)
	player.crouching_collision.set_deferred("disabled", false)
	player.animation_player.play("crouch")

func physics_update(delta: float) -> void:
	# 1. Gravedad
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta

	# 2. Movimiento agachado
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction != 0:
		player.velocity.x = direction * (player.speed * 0.5) 
		
		if direction < 0:
			player.sprite.flip_h = true
		elif direction > 0:
			player.sprite.flip_h = false
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed)

	# 3. ¡SALTO AGACHADO LIBRE!
	# No importa si hay techo o no. Si toco salto, me impulso y sigo en este estado.
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.velocity.y = player.jump_velocity

	# Aplicamos el movimiento físico
	player.move_and_slide()

	# 4. Cuándo nos levantamos (solo cuando soltás la tecla de abajo)
	if not Input.is_action_pressed("move_down"):
		
		# Si justo hay un techo, no te dejo pararte para que no te trabes
		if player.ceiling_sensor.is_colliding():
			return 
			
		# Si soltaste el botón y hay lugar, te parás
		if not player.is_on_floor():
			transitioned.emit(self, "jump")
		elif direction != 0:
			transitioned.emit(self, "run")
		else:
			transitioned.emit(self, "idle")

func exit() -> void:
	# Al salir, volvemos a ser altos
	player.standing_collision.set_deferred("disabled", false)
	player.crouching_collision.set_deferred("disabled", true)

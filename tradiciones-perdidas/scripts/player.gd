extends CharacterBody2D
class_name Player

@export var speed: float = 300.0
@export var jump_velocity: float = -400.0

# Obtenemos la gravedad de la configuración del proyecto
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var standing_collision: CollisionShape2D = $StandingCollision
@onready var crouching_collision: CollisionShape2D = $CrouchingCollision
@onready var ceiling_sensor: RayCast2D = $CeilingSensor

extends CharacterBody2D
class_name Player

@export var speed: float = 300.0
@export var jump_velocity: float = -400.0

# Obtenemos la gravedad de la configuración del proyecto
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

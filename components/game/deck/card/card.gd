extends Node2D
class_name Card

@export var front_texture: Texture2D
@export var back_texture: Texture2D
@export var color: CardEnums.CardColor
@export var suit: CardEnums.CardSuit
@export var value: CardEnums.CardValue

@onready var front_sprite: Sprite2D = $"Front"
@onready var back_sprite: Sprite2D = $"Back"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	front_sprite.texture = front_texture
	back_sprite.texture = back_texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

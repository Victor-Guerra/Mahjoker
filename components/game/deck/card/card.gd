extends Control
class_name Card

@export var card_details: CardDetails
@export var current_card_back: GlobalCardBack

@onready var front_sprite: Sprite2D = $"Front"
@onready var back_sprite: Sprite2D = $"Back"
@onready var collision_box: Area2D = $"DraggableArea"

var _mouse_over: bool = false

func _ready() -> void:
	_connect_signals()
	#render_card_front()
	render_card_back()

	back_sprite.visible = false
	front_sprite.visible = true

func _process(delta: float) -> void:
	if _mouse_over:
		self.scale = Vector2(1.2, 1.2)
	else:
		self.scale = Vector2(1.0, 1.0)
	pass

func flip_card() -> void:
	front_sprite.visible = !front_sprite.visible
	back_sprite.visible = !back_sprite.visible

func set_card_details(details: CardDetails) -> void:
	card_details = details
	render_card_front()

func render_card_front() -> void:
	front_sprite.texture = card_details.front_texture

func render_card_back() -> void:
	back_sprite.texture = current_card_back.back_texture
#
#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_accept"):
		#flip_card()

func _on_area_mouse_entered() -> void:
	self._mouse_over = true

func _on_area_mouse_exited() -> void:
	self._mouse_over = false

func _connect_signals() -> void:
	collision_box.mouse_entered.connect(_on_area_mouse_entered)
	collision_box.mouse_exited.connect(_on_area_mouse_exited)

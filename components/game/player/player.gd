extends Control
class_name Player

@export var hand: Hand
@export var discard_pile: Node ## ToDo: Change to a DiscardPile type once implemented
@export var open_sets: Node ## ToDo: Change to an OpenSet type once implemented

@export var is_human: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not is_human:
		hand.flip_hand()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

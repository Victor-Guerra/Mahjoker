extends Node2D
class_name TestHandPattern

@export var pattern_to_test: HandPattern
@export var hand_to_use: Hand

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hand_to_use.render_hand()
	
	pattern_to_test.check_if_present(hand_to_use)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

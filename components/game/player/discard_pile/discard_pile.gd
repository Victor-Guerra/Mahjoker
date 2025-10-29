extends Control
class_name DiscardPile

@onready var hand: Hand = $"Hand"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_to_discard_pile(details: CardDetails) -> void:
	hand.add_card(details, false)

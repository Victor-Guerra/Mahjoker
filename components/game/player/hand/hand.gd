extends Node2D
class_name Hand

@export var cards_in_hand: Array[CardDetails]
@export var hand_size: int = 11

@onready var card_container: FlowContainer = $Cards
var card_slots: Array[Node]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_instantiate_card_slots()
	_populate_card_slots_array()

	#sort_hand()
	#render_hand()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_card(details: CardDetails, do_sort: bool = true) -> void:
	cards_in_hand.append(details)
	if do_sort:
		sort_hand()
	render_hand()

func take_card(details: CardDetails) -> CardDetails:
	var taken_card = cards_in_hand.pop_at(cards_in_hand.find(details))
	render_hand()

	return taken_card

func render_hand() -> void: ## ToDo: Fix the ungodly amount of error messages this is producing
	for i in range(0,hand_size):
		if i > cards_in_hand.size():
			return

		if not cards_in_hand.get(i):
			card_slots.get(i).clear_card_details()
		else:
			card_slots.get(i).set_card_details(cards_in_hand.get(i))

func sort_hand() -> void:
	cards_in_hand.sort_custom(_sort_ascending_value)
	cards_in_hand.sort_custom(_sort_ascending_suit)


func _sort_ascending_value(a: CardDetails, b: CardDetails) -> bool:
	if a.value < b.value:
		return true

	return false

func _sort_ascending_suit(a: CardDetails, b: CardDetails) -> bool:
	if a.suit < b.suit:	
		return true

	return false

#func _find_card(a: CardDetails, b: CardDetails) -> bool:
	#pass

func flip_hand() -> void:
	for card in card_slots:
		card.flip_card()

func _instantiate_card_slots() -> void:
	for i in range(0, hand_size):
		var new_card = load(ScenePaths.CardScene).instantiate()
		card_container.add_child(new_card)

func _populate_card_slots_array() -> void:
	card_slots = card_container.get_children()

extends Resource
class_name Deck

@export var all_cards: Array[CardDetails]

func _init() -> void:
	pass
	#all_cards.shuffle()

func deal_card(player: Player) -> void:
		if all_cards.size() > 0:
			player.hand.add_card(all_cards.pop_back())
			player.hand.render_hand()

func shuffle() -> void:
	all_cards.shuffle()
	all_cards.shuffle()
	all_cards.shuffle()
	all_cards.shuffle()

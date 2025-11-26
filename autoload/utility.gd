extends Node

class Sort:
	static func sort_ascending_value(a: CardDetails, b: CardDetails) -> bool:
		if a.value < b.value:
			return true
		return false
	static func sort_ascending_suit(a: CardDetails, b: CardDetails) -> bool:
		if a.suit < b.suit:	
			return true
		return false

class Throuple:
	var cards: Array[CardDetails]
	
	func _init(thr: Array[CardDetails]):
		self.cards = thr
	
	func print_cards() -> void:
		for card in cards:
			card.print_card()

class ThroupleGroup:
	var sets: Array[Throuple]
	
	func _init(group: Array[Throuple]):
		self.sets = group

	func get_cards() -> Array[CardDetails]:
		var cards: Array[CardDetails] = []
		for card_set in sets:
			for card in card_set.cards:
				cards.append(card)
		
		return cards

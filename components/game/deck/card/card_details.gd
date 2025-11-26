extends Resource
class_name CardDetails

@export var front_texture: Texture2D
@export var color: CardEnums.CardColor
@export var suit: CardEnums.CardSuit
@export var value: CardEnums.CardValue

# func card_effect() -> void: ## etc if I add effects to the game

func print_card() -> void:
	print("" + CardEnums.CardValue.find_key(value) + "of" + CardEnums.CardSuit.find_key(suit))


func is_equal(obj: CardDetails) -> bool:
	return ((self.value == obj.value) and (self.color == obj.color) and (self.suit == obj.suit))

func is_card_in_list(lst: Array[CardDetails]) -> bool:
	for card in lst:
		if card.is_equal(self):
			return true

	return false
	#return lst.any(func(x: CardDetails): x.is_equal(self))

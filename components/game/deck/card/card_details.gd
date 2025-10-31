extends Resource
class_name CardDetails

@export var front_texture: Texture2D
@export var color: CardEnums.CardColor
@export var suit: CardEnums.CardSuit
@export var value: CardEnums.CardValue

# func card_effect() -> void: ## etc if I add effects to the game

func print_card() -> void:
    print("" + CardEnums.CardValue.find_key(value) + "of" + CardEnums.CardSuit.find_key(suit))
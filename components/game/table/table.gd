extends Node2D
class_name Table

@export var deck: Deck
@export var players: Array[Player]
@export var camera: Camera2D


func _ready() -> void:
	deck.shuffle()
	deal_hands()

func _process(delta: float) -> void:
	pass

func deal_hands() -> void:
	print(deck.all_cards.size())
	for i in range(0,10): ## ToDo: Change to a constant for hand size
		for player in players:
			deck.deal_card(player)
	print(deck.all_cards.size())

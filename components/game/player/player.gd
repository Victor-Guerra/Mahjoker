extends Control
class_name Player

@export_group("Player Components")
@export var hand: Hand
@export var discard_pile: DiscardPile ## ToDo: Change to a DiscardPile type once implemented
@export var open_sets: Node ## ToDo: Change to an OpenSet type once implemented
#@export var score_and_seat: ScoreSeatDisplay

@export_group("Game Related")
@export var seat: GameEnums.Seat
@export var is_human: bool

var last_dice_throw: int

signal end_turn()

func _ready() -> void:
	_bind_card_signals_to_player()
	if not is_human:
		hand.flip_hand()

func discard_card(details: CardDetails) -> void:
	discard_pile.add_to_discard_pile(hand.take_card(details))
	end_turn.emit()


func _bind_card_signals_to_player() -> void:
	for card in hand.card_slots:
		card.take_card.connect(discard_card)

func throw_dice() -> void:
	self.last_dice_throw = randi_range(1,13)

func set_seat(seat: GameEnums.Seat) -> void:
	self.seat = seat

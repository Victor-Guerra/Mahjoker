extends Node2D
class_name Table

@export var deck: Deck
@export var players: Array[Player]
@export var camera: Camera2D

@export var game_sm: StateMachine

@export var current_turn: GameEnums.Seat = GameEnums.Seat.DIAMOND

func _ready() -> void:
	game_sm.init(self)

#func _process(delta: float) -> void:
#	pass

func deal_hands() -> void:
	for i in range(0,10): ## ToDo: Change to a constant for hand size
		for player in players:
			deck.deal_card(player)

func assign_seats() -> void:
	for player in players:
		player.throw_dice()

	var highest_roll_player: Player = null
	for player in players:
		if highest_roll_player == null:
			highest_roll_player = player
		elif player.last_dice_throw > highest_roll_player.last_dice_throw:
			highest_roll_player = player
		else:
			continue

	var dealer_idx = players.find(highest_roll_player)
	for i in range(0,players.size()):
		#print("Assigned Seat no. : " + str(i))
		players.get((i+dealer_idx) % (players.size())).set_seat(i)
	
func deal_card_to_player_in_seat_of_current_turn() -> void:
	var player = get_player_of_current_turn()

	deck.deal_card(player)

func update_current_turn() -> void:
	current_turn = (current_turn + 1) % GameEnums.Seat.size() as GameEnums.Seat

func get_player_by_seat(seat: GameEnums.Seat) -> Player:
	var _find_by_seat = func (player: Player) -> bool:
		if player.seat == seat:
			return true
		return false
	return players.get(players.find_custom(_find_by_seat))

func get_player_of_current_turn() -> Player:
	return get_player_by_seat(current_turn)

func update_which_player_can_play() -> void:
	for player in players:
		player.can_play = false
	
	get_player_of_current_turn().can_play = true

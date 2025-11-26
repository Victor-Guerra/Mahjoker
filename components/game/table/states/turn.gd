extends State

@export var on_discard: State
@export var on_win: State

func enter() -> void:
	var curr_player = parent.get_player_of_current_turn()
	curr_player.end_turn.connect(_handle_on_discard)	
	#parent.game_won.connect(_handle_on_win) ## TODO: use the signal to give the player the option to win
	## Insted of automatically winning
	parent.update_which_player_can_play()
	parent.deal_card_to_player_in_seat_of_current_turn()

	parent.check_if_current_player_wins()

	pass

func exit() -> void:
	parent.get_player_of_current_turn().end_turn.disconnect(_handle_on_discard)	
	parent.game_won.disconnect(_handle_on_win)	
	parent.update_current_turn()

func _handle_on_discard() -> void:
	parent.game_sm.change_state(on_discard)

func _handle_on_win() -> void:
	parent.end_round()
	parent.game_sm.change_state(on_win)
	pass

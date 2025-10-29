extends State

@export var on_discard: State
@export var on_win: State

func enter() -> void:
	var curr_player = parent.get_player_of_current_turn()
	curr_player.end_turn.connect(_handle_on_discard)	

	parent.deal_card_to_player_in_seat_of_current_turn()

	pass

func exit() -> void:
	parent.get_player_of_current_turn().end_turn.disconnect(_handle_on_discard)	
	parent.update_current_turn()

func _handle_on_discard() -> void:
	parent.game_sm.change_state(on_discard)

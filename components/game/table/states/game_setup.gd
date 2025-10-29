extends State

@export var on_setup_finish: State

func enter() -> void:
	parent.assign_seats()
	parent.deck.shuffle()
	parent.deal_hands()

	## Here, stuff like displaying the round number and who has which seat 
	##	would be ideally displayed

	parent.game_sm.change_state(on_setup_finish)

func exit() -> void:
	pass

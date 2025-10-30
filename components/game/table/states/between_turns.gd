extends State

@export var on_no_steal: State
@export var on_steal: State

func enter() -> void:
	# prompt for stealing
	pass

func exit() -> void:
	pass

func _handle_stealing() -> void:
	parent.game_sm.change_state(on_steal)

func _handle_no_steal() -> void:
	parent.game_sm.change_state(on_no_steal)
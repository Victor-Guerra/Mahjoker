extends Node
class_name StateMachine

@export var starting_state: State
var current_state:  State
var previous_state: State

var enabled: bool = true

func _process(delta: float) -> void:
	if enabled:
		process_frame(delta)

func _physics_process(delta: float) -> void:
	if enabled: 
		process_physics(delta)
	
func _input(event: InputEvent) -> void:
	if enabled:
		process_input(event)
	
func _unhandled_input(event: InputEvent) -> void:
	if enabled: 
		process_unhandled_input(event)

func init(parent: Node) -> void:
	for child in get_children():
		child.parent = parent

	#Initialize default
	change_state(starting_state)

func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
		previous_state = current_state
		
	current_state = new_state
	current_state.enter()

## For each possible way the node is processed we need to check whether it changes state
func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_unhandled_input(event: InputEvent) -> void:
	var new_state = current_state.process_unhandled_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)

func enable() -> void:
	enabled = true

func disable() -> void:
	enabled = false

func toggle_enabled() -> void:
	enabled = !enabled

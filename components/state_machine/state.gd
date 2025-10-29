@abstract
extends Node
class_name State

#@export var connected_states: Array[State]

var parent: Control

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null

func process_input(event: InputEvent) -> State:
	return null

func process_unhandled_input(event: InputEvent) -> State:
	return null

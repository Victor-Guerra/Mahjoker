extends Node
class_name PatternManager

@export var active_patterns: Array[HandPattern]

var matching_patterns: Array[HandPattern] = []

func find_patterns_in_hand(hand: Hand) -> void:
	for pattern in active_patterns:
		if pattern.check_if_present(hand):
			matching_patterns.append(pattern)

func are_matched_patterns_a_win() -> bool:
	for pattern in matching_patterns:
		if pattern.is_win_pattern and BasePattern in matching_patterns:
			return true

	return false


func reset_matching_patterns() -> void:
	matching_patterns = []

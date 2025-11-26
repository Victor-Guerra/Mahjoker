extends HandPattern
class_name BasePattern

var is_win_pattern: bool = true ## ToDo: Change to 'false' once winning patterns are implemented
var matches: Array[Utility.Throuple] = []

func check_if_present(hand: Hand) -> bool:
	## Check if the hand contains the main win condition of having 3 sets and a pair
	var cards = hand.cards_in_hand.duplicate()

	#var number_cards = cards.filter(func (x): (_is_card_ace(x) or _is_card_number(x)))
	var number_cards = cards.filter(_is_card_number)
	number_cards.append_array(cards.filter(_is_card_ace))

	var royal_cards = cards.filter(_is_card_royal)

	var numbered_valid_sets = _remove_equivalent_throuples(_get_all_permutations_of_three(number_cards).filter(_is_throuple_a_valid_set))
	var royal_valid_sets = _remove_equivalent_throuples(_get_all_permutations_of_three(royal_cards).filter(_is_throuple_a_valid_set))

	numbered_valid_sets.append_array(royal_valid_sets)

	var numbered_exclusive_plays = _get_sets_of_exclusive_applicable_sets(cards, numbered_valid_sets)
	#var royal_exclusive_plays = _get_sets_of_exclusive_applicable_sets(cards, royal_valid_sets)
	
	## Find if any of these have a valid pair
	var full_sets = _find_the_pair(numbered_exclusive_plays, cards)
	
	if full_sets.size() > 0:
		return true

	return false

func _find_the_pair(exc_sets: Array[Utility.ThroupleGroup], cards: Array[CardDetails]) -> Array[Utility.ThroupleGroup]:
	## check if there is a valid pair remaining if we have the full 3 sets
	var full_match_sets: Array[Utility.ThroupleGroup] = []


	var _reduce_list = func (acc: Array[CardDetails], x: Utility.Throuple) -> Array[CardDetails]:
		acc.append_array(x.cards)
		return acc

	for group in exc_sets:
		var temp_cards = cards.duplicate_deep()

		var set_cards = group.get_cards()

		## We re-create the function on every loop so that the 'cards' variable inside gets updated
		var _is_card_in_hand = func (x: CardDetails) -> bool:
			var is_card_in = x.is_card_in_list(set_cards)
			return not is_card_in

		var remaining_couple = temp_cards.filter(_is_card_in_hand)

		if remaining_couple.size() != 2:
			continue
		else:
			if _is_couple_valid_pair(remaining_couple[0], remaining_couple[1]):
				group.sets.append(Utility.Throuple.new(remaining_couple))
				full_match_sets.append(group)

	return full_match_sets

#func _init(cards_in_hand: Array[CardDetails]) -> void:
	#pass

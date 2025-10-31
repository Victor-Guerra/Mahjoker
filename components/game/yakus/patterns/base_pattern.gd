extends HandPattern
class_name BasePattern

var is_win_pattern: bool = true ## ToDo: Change to 'false' once winning patterns are implemented

func check_if_present(hand: Hand) -> bool:
	## Check if the hand contains the main win condition of having 3 sets and a pair
	var cards = hand.cards_in_hand.duplicate()

	#var number_cards = cards.filter(func (x): (_is_card_ace(x) or _is_card_number(x)))
	var number_cards = cards.filter(_is_card_number)
	number_cards.append_array(cards.filter(_is_card_ace))

	var royal_cards = cards.filter(_is_card_royal)

	var numbered_valid_sets = _remove_equivalent_throuples(_get_all_permutations_of_three(number_cards).filter(_is_throuple_a_valid_set))
	var royal_valid_sets = _remove_equivalent_throuples(_get_all_permutations_of_three(royal_cards).filter(_is_throuple_a_valid_set))


	var numbered_exclusive_plays = _get_sets_of_exclusive_applicable_sets(cards, numbered_valid_sets)
	var royal_exclusive_plays = _get_sets_of_exclusive_applicable_sets(cards, royal_valid_sets)

	#print("Current Sets: ")
	#for nset in numbered_valid_sets:
		#nset.print_cards()
		#print("")
#
	#for nset in royal_valid_sets:
	#	nset.print_cards()
	#	print("")
	
	for play in numbered_exclusive_plays:
		for nset in play.sets:
			nset.print_cards()
			print("")

		print("################")

	for play in royal_exclusive_plays:
		for nset in play.sets:
			nset.print_cards()
			print("")

		print("################")


	return false

#func _find_the_pair(exc_sets: Utility.ThroupleGroup) -> Array[CardDetails]:

@abstract
extends Resource
class_name HandPattern

@abstract func check_if_present(hand: Hand) -> bool

#region Card operations

func _is_card_red(card: CardDetails) -> bool:
	return card.color == CardEnums.CardColor.RED

func _is_card_black(card: CardDetails) -> bool:
	return card.color == CardEnums.CardColor.BLACK

func _is_card_ace(card: CardDetails) -> bool:
	return card.value == CardEnums.CardValue.ACE

func _is_card_number(card: CardDetails) -> bool:
	return (card.value == CardEnums.CardValue.TWO 
			or card.value == CardEnums.CardValue.THREE
			or card.value == CardEnums.CardValue.FOUR
			or card.value == CardEnums.CardValue.FIVE
			or card.value == CardEnums.CardValue.SIX
			or card.value == CardEnums.CardValue.SEVEN
			or card.value == CardEnums.CardValue.EIGHT
			or card.value == CardEnums.CardValue.NINE
			or card.value == CardEnums.CardValue.TEN)

func _is_card_royal(card: CardDetails) -> bool:
	return (card.value == CardEnums.CardValue.JACK 
			or card.value == CardEnums.CardValue.QUEEN
			or card.value == CardEnums.CardValue.KING)

func _is_card_diamond(card: CardDetails) -> bool:
	return card.suit == CardEnums.CardSuit.DIAMOND

func _is_card_spade(card: CardDetails) -> bool:
	return card.suit == CardEnums.CardSuit.SPADE

func _is_card_club(card: CardDetails) -> bool:
	return card.suit == CardEnums.CardSuit.CLUB

func _is_card_heart(card: CardDetails) -> bool:
	return card.suit == CardEnums.CardSuit.HEART

#region Throuple creation

func _get_premutation_of_three(cards: Array[CardDetails], i: int, j: int, k: int) -> Utility.Throuple:
	## Get a Throuple object of 3 cards taken from the specified indices of the 'cards' array
	return Utility.Throuple.new([cards.get(i), cards.get(j), cards.get(k)])

func _get_all_permutations_of_three(cards: Array[CardDetails]) -> Array[Utility.Throuple]:
	## Get all possible sets of three from an array of cards
	var throuples: Array[Utility.Throuple] = []
	for i in range(0, cards.size()-2):
		for j in range(i+1, cards.size()-1):
			for k in range(j+1, cards.size()):
				throuples.append(_get_premutation_of_three(cards, i, j, k))
	
	return throuples

#region Throuple operations

func _is_throuple_a_sequence(throuple: Utility.Throuple) -> bool:
	## Check if the three cards in this set are a valid same-color and of immediately-sequenced set
	if not (throuple.cards.all(_is_card_red) or throuple.cards.all(_is_card_black)):
		return false

	print("checking if sequence")
	throuple.cards.sort_custom(Utility.Sort.sort_ascending_value)
	throuple.print_cards()

	return (throuple.cards.get(1).value == (throuple.cards.get(0).value + 1 as CardEnums.CardValue) 
			and throuple.cards.get(2).value == (throuple.cards.get(1).value + 1 as CardEnums.CardValue))
		
func _is_throuple_a_triplet(throuple: Utility.Throuple) -> bool:
	## Check if the three cards in this set are a valid same-color and same-value set
	if not (throuple.cards.all(_is_card_red) 
			or throuple.cards.all(_is_card_black)):
		return false

	return (throuple.cards.get(0).value == throuple.cards.get(1).value and throuple.cards.get(1).value == throuple.cards.get(2).value)

func _is_throuple_a_valid_set(throuple: Utility.Throuple) -> bool:
	## For checking if it's either a sequence or a triplet
	return (_is_throuple_a_sequence(throuple) or _is_throuple_a_triplet(throuple))

func _remove_equivalent_throuples(sets: Array[Utility.Throuple]) -> Array[Utility.Throuple]:
	## For removing all Sets which are equivalent, that is, they use the same cards just in a different order
	var to_pop: Array[int] = []
	for i in range(0, sets.size()):
		for j in range(i+1, sets.size()):
			## Check if all cards in this set have a matching value:color pair in the other set
			if sets.get(i).cards.all(
				func (card): sets.get(j).cards.any(
					func (x): (x.value == card.value and x.color == card.color)
				)):
					to_pop.append(j)

	for i in to_pop:
		sets.pop_at(i)

	return sets

func _get_sets_of_exclusive_applicable_sets(all_cards: Array[CardDetails], all_sets: Array[Utility.Throuple]) -> Array[Utility.ThroupleGroup]:
	## This can DEFINITELY be simplified by using recursion, but later :b ## ToDo
	var exclusive_applicable_sets: Array[Utility.ThroupleGroup] = []
	for i in range(0,all_sets.size()):
		var new_group = []
		## remove cards to see if other sets can still be formed with the remaining cards
		var remaining_cards = all_cards.filter(func (x): x not in all_sets.get(i).cards)

		# In case no more sets of 3 can possibly fit in the given cards
		new_group.append(all_sets.get(i))
		if remaining_cards.size() < 3:
			continue

		for j in range(i+1, all_sets.size()):
			## remove cards to see if other sets can still be formed with the remaining cards
			if all_sets.get(j).cards.all(func (x): x in remaining_cards):
				remaining_cards = remaining_cards.filter(func (x): x not in all_sets.get(j).cards)

				# In case no more sets of 3 can possibly fit in the given cards
				new_group.append(all_sets.get(j))
				if remaining_cards.size() < 3:
					continue

				for k in range(j+1, all_sets.size()):
					if all_sets.get(k).cards.all(func (x): x in remaining_cards):
						remaining_cards = remaining_cards.filter(func (x): x not in all_sets.get(k).cards)

						# In case no more sets of 3 can possibly fit in the given cards
						new_group.append(all_sets.get(k))
						if remaining_cards.size() < 3:
							continue
					else:
						continue

			else:
				continue

		exclusive_applicable_sets.append(Utility.ThroupleGroup.new(new_group))
	return exclusive_applicable_sets

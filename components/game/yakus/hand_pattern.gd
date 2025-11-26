@abstract
extends Resource
class_name HandPattern

@abstract func check_if_present(hand: Hand) -> bool
#@abstract func _init(cards_in_hand: Array[CardDetails]) -> void
@abstract func get_matches(hand: Hand) -> Array[Utility.ThroupleGroup]
var point_value: int
var is_win_pattern: bool

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

#region Pair checking

func _is_couple_valid_pair(c1: CardDetails, c2: CardDetails) -> bool:
	return ((c1.value == c2.value) and (c1.color == c2.color))

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

	throuple.cards.sort_custom(Utility.Sort.sort_ascending_value)

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
					func (x): return (x.value == card.value and x.color == card.color)
				)):
					to_pop.append(j)

	for i in to_pop:
		sets.pop_at(i)

	return sets

func __get_new_group(start_idx: int, sets: Array[Utility.Throuple], cards: Array[CardDetails]) -> Array[Utility.Throuple]:
	var ns: Array[Utility.Throuple] = []

	for i in range(0, sets.size()):
		var idx = (i + start_idx) % sets.size()
		##
		## Issue [is] was in the lambda funcs used, replaced by the ones below
		##
		var _is_card_in_set = func (x: CardDetails) -> bool:
			var is_card_in = not (x.is_card_in_list(sets.get(idx).cards))
			return is_card_in

		var _is_card_in_hand = func (x: CardDetails) -> bool:
			var is_card_in = x.is_card_in_list(cards)
			return is_card_in

		if sets.get(idx).cards.all(_is_card_in_hand):
			#sets.get(idx).print_cards()
			ns.append(sets.get(idx))
			cards = cards.filter(_is_card_in_set)

	return ns

## ToDo
#func _remove_redundant_exclusive_applicable_sets(sets: Array[Utility.ThroupleGroup]) -> Array[Utility.ThroupleGroup]:


func _get_sets_of_exclusive_applicable_sets(all_cards: Array[CardDetails], all_sets: Array[Utility.Throuple]) -> Array[Utility.ThroupleGroup]:
	var exclusive_applicable_sets: Array[Utility.ThroupleGroup] = []
	for i in range(0, all_sets.size()):
		var new_group = __get_new_group(i, all_sets.duplicate_deep(), all_cards.duplicate_deep())

		#for nset in new_group:
			#nset.print_cards()
		#print("#######")

		exclusive_applicable_sets.append(Utility.ThroupleGroup.new(new_group))

	return exclusive_applicable_sets

class_name Triplet
## Experimental Class

func check_if_present(throuple: Utility.Throuple) -> bool:
	return throuple.all(_have_same_number) and throuple.all(_have_same_color)

func _have_same_number(throuple: Utility.Throuple) -> bool:
	for val in CardEnums.CardValue.values():
		if throuple.cards.all(func (x): x == val):
			return true

	return false

func _have_same_color(throuple: Utility.Throuple) -> bool:
	for val in CardEnums.CardColor.values():
		if throuple.cards.all(func (x): x == val):
			return true

	return false
	

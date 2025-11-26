extends CenterContainer
class_name GameAnnouncement

@export var announcement_text: GameEnums.GameAction

@onready var ann_label: RichTextLabel = $Label
@onready var ann_timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ann_label.visible = false
	ann_timer.timeout.connect(_hide_announcement)

	## debug
	#show_announcement(GameEnums.GameAction.STEAL)

func _set_announcement(action: GameEnums.GameAction) -> void:
	announcement_text = action
	ann_label.text = GameEnums.GameAction.find_key(announcement_text)

func show_announcement(action: GameEnums.GameAction) -> void:
	_set_announcement(action)
	_show_announcement()
	ann_timer.start()


func _show_announcement() -> void:
	ann_label.visible = true

func _hide_announcement() -> void:
	ann_label.visible = false

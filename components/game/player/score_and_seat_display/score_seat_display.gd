extends Control
class_name ScoreSeatDisplay

@export var seat_icon_texture: Texture2D
@export var points: int = 20

@onready var seat_icon: TextureRect = $"Background/GridContainer/SeatIcon"
@onready var points_label: RichTextLabel = $"Background/GridContainer/PointsDisplay/PointsValueLabel"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_render_icon()
	_render_points()
	pass # Replace with function body.


func _render_points() -> void:
	points_label.text = str(points)

func _render_icon() -> void:
	seat_icon.texture = seat_icon_texture

func set_seat_icon(icon: Texture2D) -> void:
	seat_icon_texture = icon
	_render_icon()

func add_points(amnt: int) -> void:
	points += amnt
	_render_points()

extends Control
class_name ScoreScreenDisplay

@export var seat_icon_texture: Texture2D
@export var initial_points: int = 20

@onready var seat_icon: TextureRect = $"Background/GridContainer/SeatIcon"
@onready var points_label: RichTextLabel = $"Background/GridContainer/PointsDisplay/PointsValueLabel"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Node

enum Seat {
	DIAMOND,
	SPADE,
	CLUB,
	HEART
}

const SeatIcons: Dictionary[Seat, String] = {
	Seat.DIAMOND: "res://assets/sprites/atlases/diamond_icon.tres",
	Seat.SPADE: "res://assets/sprites/atlases/spade_icon.tres",
	Seat.CLUB: "res://assets/sprites/atlases/club_icon.tres",
	Seat.HEART: "res://assets/sprites/atlases/heart_icon.tres"
}

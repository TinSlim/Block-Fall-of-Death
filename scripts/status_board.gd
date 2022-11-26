extends Node2D

onready var status = $Status

func update_piece():
	status.update_next_piece()

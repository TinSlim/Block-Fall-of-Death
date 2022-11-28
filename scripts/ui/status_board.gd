extends Node2D

onready var status = $Status

func update_piece():
	status.update_next_piece()

func update_lava_count(value):
	status.lava_count_number = value

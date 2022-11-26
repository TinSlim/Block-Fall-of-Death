extends Node

var BLOCK_SIZE = 32

var _SCENE_BLUE_RICKY = preload("res://scenes/pieces/blue_ricky.tscn")
var _SCENE_CLEVELAND_Z = preload("res://scenes/pieces/cleveland_z.tscn")
var _SCENE_HERO = preload("res://scenes/pieces/hero.tscn")
var _SCENE_ORANGE_RICKY = preload("res://scenes/pieces/orange_ricky.tscn")
var _SCENE_RHODE_ISLAND_Z = preload("res://scenes/pieces/rhode_island_z.tscn")
var _SCENE_SMASHBOY = preload("res://scenes/pieces/smashboy.tscn")
var _SCENE_TEEWEE = preload("res://scenes/pieces/teewee.tscn")

onready var _PIECES_ARRAY = [
	[_SCENE_BLUE_RICKY, 	Vector2(BLOCK_SIZE / 2, BLOCK_SIZE)] ,
	[_SCENE_CLEVELAND_Z, 	Vector2(-BLOCK_SIZE / 2, 0)],
	[_SCENE_HERO, 			Vector2(-BLOCK_SIZE / 2,0)],
	[_SCENE_ORANGE_RICKY, 	Vector2(-BLOCK_SIZE / 2, BLOCK_SIZE)] ,
	[_SCENE_RHODE_ISLAND_Z, Vector2(BLOCK_SIZE / 2,0)],
	[_SCENE_SMASHBOY, 		Vector2(BLOCK_SIZE / 2, BLOCK_SIZE / 2)],
	[_SCENE_TEEWEE, 		Vector2(0, BLOCK_SIZE / 2)]
	]

var _piece_index = 0

func _ready():
	_PIECES_ARRAY.shuffle()

func get_piece():
	return _PIECES_ARRAY[_piece_index][0]

func get_adjust():
	return _PIECES_ARRAY[_piece_index][1]

func update_index():
	_piece_index += 1
	if _piece_index == len(_PIECES_ARRAY):
		_PIECES_ARRAY.shuffle()
		_piece_index = 0

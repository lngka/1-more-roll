extends Area2D

@export var face_textures: Array[Texture2D]
var value := 1


func roll():
	value = randi_range(1, 6)
	$Face.texture = face_textures[value - 1]

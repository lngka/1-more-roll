extends Area2D

@export var face_textures: Array[Texture2D]
@export var held_color := Color.DODGER_BLUE
@export var held_width := 4.0

var value := 1
var held := false


func roll():
	if held:
		return
	value = randi_range(1, 6)
	_update_face()


func _update_face():
	$Face.texture = face_textures[value - 1]
	queue_redraw()
	
func _draw():
	if not held:
		return
	var rect: Rect2 = $Face.get_rect().grow(held_width / 2)
	draw_rect(rect, held_color, false, held_width)
	
func _on_input_event(_viewport, event: InputEvent, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		held = not held
		_update_face()

extends Node2D

@export var roll_sounds: Array[AudioStream]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_roll_button_pressed() -> void:
	var any_rolled := false
	for die in $DiceGroup.get_children():
		if die.held:
			continue
		die.roll()
		any_rolled = true
	if any_rolled:
		$RollSound.stream = roll_sounds.pick_random()
		$RollSound.play()

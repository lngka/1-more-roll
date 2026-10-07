extends Node2D

@export var roll_sounds: Array[AudioStream]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Music.play()
	for die in $DiceGroup.get_children():
		die.held_changed.connect(_on_die_held_changed)


func _on_die_held_changed() -> void:
	var values: Array[int] = []
	for die in $DiceGroup.get_children():
		if die.held:
			values.append(die.value)
	$CanvasLayer/HeldScoreLabel.text = "Round: %d" % score_dice(values)


# Một viên xúc xắc chỉ thuộc một tổ hợp. Sảnh và bộ ba có thể tranh nhau
# cùng một nhóm mặt, nên thử cả hai cách rồi lấy điểm cao hơn.
# Ví dụ 2,3,4,5,5,6: sảnh 2–6 (750) + một mặt 5 (50) = 800,
# cao hơn cách không lấy sảnh (hai mặt 5 = 100).
func score_dice(values: Array) -> int:
	var counts: Array[int] = [0, 0, 0, 0, 0, 0, 0]
	for value in values:
		counts[value] += 1

	var best := _score_matches(counts)
	# Sảnh 1–6 dùng hết 6 viên, không còn viên lẻ.
	if _has_straight(counts, 1, 6):
		best = maxi(best, 1500)
	# Sảnh ngắn lấy đúng một viên mỗi mặt. Viên thừa (mặt 1 hoặc 5 thứ hai)
	# được chấm riêng, không gộp lại thành sảnh.
	if _has_straight(counts, 1, 5):
		best = maxi(best, 500 + _score_matches(_without_straight(counts, 1, 5)))
	if _has_straight(counts, 2, 6):
		best = maxi(best, 750 + _score_matches(_without_straight(counts, 2, 6)))
	return best


func _has_straight(counts: Array[int], from: int, to: int) -> bool:
	for face in range(from, to + 1):
		if counts[face] < 1:
			return false
	return true


func _without_straight(counts: Array[int], from: int, to: int) -> Array[int]:
	var left := counts.duplicate()
	for face in range(from, to + 1):
		left[face] -= 1
	return left


# Không có sảnh: bộ ba trở lên, rồi mặt 1 và 5 còn lại.
# Mặt 2, 3, 4, 6 đứng ít hơn 3 viên thì không có điểm.
func _score_matches(counts: Array[int]) -> int:
	var points := 0
	for face in range(1, 7):
		var n := counts[face]
		if n >= 3:
			var base := 1000 if face == 1 else face * 100
			# Mỗi viên cùng mặt thêm sau bộ ba thì nhân đôi:
			# 3 viên ×1, 4 viên ×2, 5 viên ×4, 6 viên ×8.
			points += base * (1 << (n - 3))
		elif face == 1:
			points += 100 * n
		elif face == 5:
			points += 50 * n
	return points


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

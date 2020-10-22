extends Node

func lookup_rotation(tile):
	var rotations = []
	if tile & 1 == 1:
		rotations.append(0)
	if tile & 2 == 2:
		rotations.append(90)
	if tile & 4 == 4:
		rotations.append(180)
	if tile & 8 == 8:
		rotations.append(270)
	return rotations

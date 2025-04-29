extends Node

var positions: Dictionary

func setPosition(levelName: String, position: Vector2):
	positions[levelName] = position

func getPosition(levelName):
	return positions[levelName] if levelName in positions else null

func hasPosition(levelName):
	return levelName in positions

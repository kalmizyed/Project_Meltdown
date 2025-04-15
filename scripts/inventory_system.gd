extends Node

var items: Array[Node2D]

func on_item_collected(item: Node2D):
	items.append(item)

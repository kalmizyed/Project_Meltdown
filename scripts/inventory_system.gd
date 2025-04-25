extends Node

var items: Array[Node2D]
var collected: Array[String] = []

func on_item_collected(item: Node2D):
	items.append(item)
	collected.append(item.name)
	
func is_collected(itemName: String) -> bool:
	return itemName in collected

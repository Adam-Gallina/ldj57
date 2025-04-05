extends Node

var stones : Array[Node3D] = []

var items : Dictionary = {}

func add_item(item):
    if not item is Grabbable: return

    if item.ItemName == 'Stone':
        stones.append(item)
        item.get_parent().remove_child(item)
    else:
        items[item.ItemName] = item

func contains_item(item_name):
    return items.find_key(item_name)

func remove_item(item_name):
    if contains_item(item_name):
        var item = items[item_name]
        items.erase(item_name)
        return item
    return null

func remove_stone():
    var s = stones.pop_front()
    get_parent().get_parent().add_child(s)
    return s
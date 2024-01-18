extends Control

#signal for event
signal on_button_event(index : int)

func on_item_button_event(index):	
	emit_signal("on_button_event", index)

func set_data(parent_index):	
	var count = get_child_count()
	for i in range(count):
		var button = get_child(i) as Button		
		button.text = "index : %d" % (parent_index)
		button.disconnect("button_up",on_item_button_event.bind(parent_index))
		button.connect("button_up", on_item_button_event.bind(parent_index))
	pass

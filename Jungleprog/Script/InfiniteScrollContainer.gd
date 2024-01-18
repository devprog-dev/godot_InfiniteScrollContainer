#version 1.0
#created by jungleprog

extends ScrollContainer

@onready var vBoxContainer = $VBoxContainer
@onready var templateItem = $VBoxContainer/TemplateItem

var is_pressed : bool = false
var is_set_scolle_size : bool = false
var scroll_min : int = -1
var scroll_max : int = -1

var data_list = []

var box_container_list = []

var is_flash = false
var vertical_value = 0
var container_index = 0
var end_line = 0 #520
var data_index = 0  # max scroll
var max_container = 12
var v_item_size = 0
var v_item_last_size = 0

var delay_release : float = 0
var is_delay : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():

	# create data
	for i in 50:
		data_list.append(i)	

	templateItem.hide()	
	data_index = max_container
	for i in max_container:
		if templateItem:		
			var newBoxContainer = templateItem.duplicate()		
			box_container_list.append(newBoxContainer)
			vBoxContainer.add_child(newBoxContainer)
			(newBoxContainer as Control).visible =  true
			newBoxContainer.connect("on_button_event", on_select_index)
			newBoxContainer.set_data(i)		
			newBoxContainer.name = "Box%d" % i
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if is_delay:
		delay_release += delta
		if delay_release >= 0.3:
			is_delay = false	
			is_pressed = false		
	pass


func on_select_index(index):
	if !is_pressed:
		print("select button %d" % index)

func _on_gui_input(event):	

	if is_pressed:
		if event is InputEventScreenTouch and event.is_pressed() == false:			
			is_delay = true	
			delay_release = 0	

	if event is InputEventScreenDrag:	
		init_scroll()	
		# Scrolling
		is_pressed = true							
		
		vertical_value += -event.relative.y		
		if vertical_value <= 0:
			vertical_value = 0			
		elif vertical_value >= end_line:
			vertical_value = end_line
			
		# Down Scroll
		if scroll_vertical >= end_line and data_index < data_list.size():				
			scroll_vertical = v_item_last_size
			vertical_value = v_item_last_size

			var box = box_container_list[container_index]				
			box.set_data(data_index)				
			vBoxContainer.move_child(box, max_container)

			data_index += 1
			container_index += 1
			if container_index >= box_container_list.size():
				container_index = 0

		# UP Scroll
		if scroll_vertical <= 0 and data_index > max_container:
			data_index -= 1
			container_index -= 1				
			if container_index < 0:
				container_index = box_container_list.size() - 1
					
			scroll_vertical = v_item_size
			vertical_value = v_item_size				

			var new_index = data_index - max_container		
			var box = box_container_list[container_index]									
			box.set_data(new_index)										
			vBoxContainer.move_child(box, 0)	
		
		scroll_vertical = vertical_value		

func init_scroll():
	if !is_set_scolle_size:
		
		is_set_scolle_size = true
		var bar = self.get_v_scroll_bar()
		scroll_min = bar.min_value
		scroll_max = bar.max_value		
		end_line = bar.max_value - get_rect().size.y
		v_item_size = templateItem.get_rect().size.y

		var rest_item_size = int(v_item_size) - int(get_rect().size.y) % int(v_item_size)		
		v_item_last_size = v_item_size * 2 + rest_item_size
		
		
		print(get_rect().size.y)
		print(v_item_last_size)
		print(v_item_size)
		print("min = %d" % bar.min_value)
		print("max = %d" % bar.max_value)
		print(end_line)

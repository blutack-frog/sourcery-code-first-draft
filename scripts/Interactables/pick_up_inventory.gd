extends Interactable

func _ready():
	$"../../CanvasLayer/invntry_button".visible = false
	$"../../CanvasLayer".invntry_enabled = false
	

func complete():
	$"../../CanvasLayer/invntry_button".visible = true
	$"../../CanvasLayer".invntry_enabled = true
	$".".queue_free()

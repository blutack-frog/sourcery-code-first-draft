extends Interactable

func _ready():
	$"../../CanvasLayer/book_button".visible = false
	$"../../CanvasLayer".skillbook_enabled = false
	

func complete():
	$"../../CanvasLayer/book_button".visible = true
	$"../../CanvasLayer".skillbook_enabled = true
	$".".queue_free()

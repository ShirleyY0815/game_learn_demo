class_name Player extends CharacterBody2D
   
var cardinal_direction:Vector2=Vector2.DOWN
var direction : Vector2=Vector2.ZERO
var move_speed : float = 100.0
var state:String="idle"

@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D =  $Sprite2D
func _ready():
	pass # replace with func body.
	
func _process( delta ):
	
	direction.x=Input.get_action_strength("right")-Input.get_action_strength("left")
	direction.y =Input.get_action_strength("donw")-Input.get_action_strength("up")
	
	velocity = direction * move_speed

	pass


func _physics_process(delta: float):
	move_and_slide() 
	
	
	
	
	
	

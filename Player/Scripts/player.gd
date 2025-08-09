class_name Player extends CharacterBody2D
   
var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var move_speed: float = 100.0
var state: String = "idle"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	# 初始播放idle_down动画
	animation_player.play("idle_down")

func _process(delta):
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	velocity = direction * move_speed
	
	# 更新状态
	update_state()
	
	# 更新方向
	update_cardinal_direction()
	
	# 播放动画
	play_animation()

func _physics_process(delta: float):
	move_and_slide()

func update_state():
	# 根据是否有移动输入来更新状态
	if direction != Vector2.ZERO:
		state = "walk"
	else:
		state = "idle"

func update_cardinal_direction():
	# 只有在有移动输入时才更新方向
	if direction != Vector2.ZERO:
		# 优先考虑水平方向
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				cardinal_direction = Vector2.RIGHT
			else:
				cardinal_direction = Vector2.LEFT
		else:
			if direction.y > 0:
				cardinal_direction = Vector2.DOWN
			else:
				cardinal_direction = Vector2.UP

func play_animation():
	var animation_name = ""
	
	# 根据状态和方向确定动画名称
	if state == "idle":
		if cardinal_direction == Vector2.DOWN:
			animation_name = "idle_down"
		elif cardinal_direction == Vector2.UP:
			animation_name = "idle_up"
		else:  # LEFT or RIGHT
			animation_name = "idle_side"
	elif state == "walk":
		if cardinal_direction == Vector2.DOWN:
			animation_name = "walk_down"
		elif cardinal_direction == Vector2.UP:
			animation_name = "walk_up"
		else:  # LEFT or RIGHT
			animation_name = "walk_side"
	
	# 处理左右翻转
	if cardinal_direction == Vector2.LEFT:
		sprite.flip_h = true
	elif cardinal_direction == Vector2.RIGHT:
		sprite.flip_h = false
	
	# 播放动画（如果不是当前播放的动画）
	if animation_player.current_animation != animation_name:
		animation_player.play(animation_name)

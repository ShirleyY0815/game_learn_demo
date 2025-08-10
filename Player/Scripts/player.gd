class_name Player extends CharacterBody2D
   
var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var look_direction: Vector2 = Vector2.ZERO  # 新增：朝向方向
var move_speed: float = 100.0
var state: String = "idle"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D



func _ready():
	# 初始播放idle_down动画
	animation_player.play("idle_down")

func _process(delta):
	# 左摇杆控制移动（行动路线）
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	# 右摇杆控制朝向
	look_direction.x = Input.get_action_strength("look_right") - Input.get_action_strength("look_left")
	look_direction.y = Input.get_action_strength("look_down") - Input.get_action_strength("look_up")
	
	velocity = direction * move_speed
	
	# 更新状态（基于左摇杆的移动）
	update_state()
	
	# 更新朝向（基于右摇杆，如果无输入则跟随移动方向）
	update_cardinal_direction()
	
	# 播放动画
	play_animation()

func _physics_process(delta: float):
	move_and_slide()

func update_state():
	# 根据左摇杆的移动输入来更新状态
	if direction != Vector2.ZERO:
		state = "walk"
	else:
		state = "idle"

func update_cardinal_direction():
	var direction_to_use = Vector2.ZERO
	
	# 优先使用右摇杆的朝向输入
	if look_direction != Vector2.ZERO:
		direction_to_use = look_direction
	# 如果右摇杆无输入，则使用左摇杆的移动方向
	elif direction != Vector2.ZERO:
		direction_to_use = direction
	# 如果两个摇杆都无输入，保持当前朝向
	else:
		return
	
	# 根据输入方向更新朝向
	if abs(direction_to_use.x) > abs(direction_to_use.y):
		if direction_to_use.x > 0:
			cardinal_direction = Vector2.RIGHT
		else:
			cardinal_direction = Vector2.LEFT
	else:
		if direction_to_use.y > 0:
			cardinal_direction = Vector2.DOWN
		else:
			cardinal_direction = Vector2.UP

func play_animation():
	var animation_name = ""
	
	# 根据状态和朝向确定动画名称
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

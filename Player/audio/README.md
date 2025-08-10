# 角色音频文件说明

## 支持的音频格式

### 推荐格式
- **OGG Vorbis** (`.ogg`) - 最佳选择
  - 压缩率高，文件小
  - 音质好，加载快
  - 无版权问题

### 其他格式
- **WAV** (`.wav`) - 无损，适合短音效
- **MP3** (`.mp3`) - 通用格式，注意版权
- **FLAC** (`.flac`) - 无损压缩

## 建议的音频文件结构

```
Player/audio/
├── footsteps/
│   ├── footstep_grass.ogg
│   ├── footstep_stone.ogg
│   └── footstep_wood.ogg
├── actions/
│   ├── jump.ogg
│   ├── land.ogg
│   └── attack.ogg
├── environment/
│   ├── breathing.ogg
│   └── equipment_rattle.ogg
└── README.md
```

## 音频文件规格建议

### 脚步声
- **格式**: OGG Vorbis
- **采样率**: 44.1 kHz
- **时长**: 0.1-0.3秒
- **音量**: -12dB 到 -6dB

### 动作音效
- **格式**: OGG Vorbis
- **采样率**: 44.1 kHz
- **时长**: 0.2-1.0秒
- **音量**: -10dB 到 -3dB

### 环境音效
- **格式**: OGG Vorbis
- **采样率**: 44.1 kHz
- **时长**: 1.0-3.0秒
- **音量**: -20dB 到 -15dB

## 使用示例

在 `player.gd` 中加载音频：

```gdscript
func load_audio_resources():
    # 加载脚步声
    footstep_sounds.append(preload("res://Player/audio/footsteps/footstep_grass.ogg"))
    footstep_sounds.append(preload("res://Player/audio/footsteps/footstep_stone.ogg"))
    
    # 加载动作音效
    jump_sound = preload("res://Player/audio/actions/jump.ogg")
    land_sound = preload("res://Player/audio/actions/land.ogg")
    attack_sound = preload("res://Player/audio/actions/attack.ogg")
```

## 音频优化建议

1. **文件大小**: 保持音频文件尽可能小
2. **循环**: 对于长音效，考虑使用循环播放
3. **空间化**: 使用3D音频来增强沉浸感
4. **音量控制**: 提供用户音量调节选项
5. **内存管理**: 及时释放不需要的音频资源 
import 'package:audioplayers/audioplayers.dart';
import '../widget/calculate.dart';
import 'package:flutter/material.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';

class BuildButton extends StatefulWidget {
  final String str;
  final Calculator calculator;
  const BuildButton({super.key, required this.str, required this.calculator});

  @override
  _BuildButtonState createState() => _BuildButtonState();
}
//状态模式？
class _BuildButtonState extends State<BuildButton> {
  bool _isPressed = false;
  //shake控制器
  final ShakeAnimationController _shakeAnimationController = ShakeAnimationController();
  //音频播放器
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return ShakeAnimationWidget(
      //抖动控制器
      shakeAnimationController: _shakeAnimationController,
      //微旋转的抖动
      shakeAnimationType: ShakeAnimationType.SkewShake,
      //设置不开启抖动
      isForward: false,
      //默认为 0 无限执行
      shakeCount: 0,
      //抖动的幅度 取值范围为[0,1]
      shakeRange: 0.2,
      //执行抖动动画的子Widget
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(70, 70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          widget.str,
          style: const TextStyle(fontSize: 30),
        ),
        onPressed: () async {
          setState(() {
            _isPressed = !_isPressed;
            if (_isPressed) {
              _shakeAnimationController.start(shakeCount: 1);
            } else {
              _shakeAnimationController.stop();
            }
            _isPressed = !_isPressed;
            widget.calculator.onButtonPressed(widget.str);
          });
          // 创建一个映射，将字符串映射到音频文件路径
          final audioPaths = {
            '+': 'audios/add.MP3',
            '-': 'audios/min.MP3',
            '×': 'audios/times.MP3',
            '÷': 'audios/mul.MP3',
            '(': 'audios/Lopen.MP3',
            ')': 'audios/Ropen.MP3',
            '.': 'audios/point.MP3',
            '=': 'audios/equal.MP3',
            'C': 'audios/clear.MP3',
            'D': '',
          };

          // 播放音频的函数
          Future<void> playAudio(String str) async {
            // 获取对应的音频路径，如果找不到，则使用默认路径
            final audioPath = audioPaths[str] ?? 'audios/${str}.MP3';

            // 如果路径非空，则播放音频
            if (audioPath.isNotEmpty) {
              await _audioPlayer.play(AssetSource(audioPath));
            }
          }

          // 调用播放音频的函数
          await playAudio(widget.str);

        },
      ),
    );
  }
}

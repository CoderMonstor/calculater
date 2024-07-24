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

class _BuildButtonState extends State<BuildButton> {
  bool _isPressed = false;
  final ShakeAnimationController _shakeAnimationController = ShakeAnimationController();
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
          switch (widget.str) {
            case '+':
              await _audioPlayer.play(AssetSource('audios/add.MP3'));
              break;
            case '-':
              await _audioPlayer.play(AssetSource('audios/min.MP3'));
              break;
            case '×':
              await _audioPlayer.play(AssetSource('audios/times.MP3'));
              break;
            case '÷':
              await _audioPlayer.play(AssetSource('audios/mul.MP3'));
              break;
            case '(':
              await _audioPlayer.play(AssetSource('audios/Lopen.MP3'));
              break;
            case ')':
              await _audioPlayer.play(AssetSource('audios/Ropen.MP3'));
              break;
             case '.':
               await _audioPlayer.play(AssetSource('audios/point.MP3'));
               break;
             case '=':
               await _audioPlayer.play(AssetSource('audios/equal.MP3'));
               break;
             case 'C':
               await _audioPlayer.play(AssetSource('audios/clear.MP3'));
               break;
             case 'D':
               // await _audioPlayer.play(AssetSource('audios/delete.MP3'));
              break;
            default:
              await _audioPlayer.play(AssetSource('audios/${widget.str}.MP3'));
              break;
          }
        },
      ),
    );
  }
}

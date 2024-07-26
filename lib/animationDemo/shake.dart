import 'package:flutter/material.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';
import '../widget/calculate.dart';
import 'audio_player.dart';

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
  final AudioPlayerService _audioPlayerService = AudioPlayerService();

  @override
  Widget build(BuildContext context) {
    return ShakeAnimationWidget(
      shakeAnimationController: _shakeAnimationController,
      shakeAnimationType: ShakeAnimationType.LeftRightShake,
      isForward: false,
      shakeCount: 0,
      shakeRange: 0.2,
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

          // 调用播放音频的函数
          await _audioPlayerService.playAudio(widget.str);
        },
      ),
    );
  }
}

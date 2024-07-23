import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'calculate.dart';

class ClearButton extends StatelessWidget {
  final Calculator calculator;
  final AudioPlayer _audioPlayer = AudioPlayer();

  ClearButton({super.key, required this.calculator});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:() async {
        calculator.clearButton();
        await _audioPlayer.play(AssetSource('audios/clear.MP3'));
        },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(70, 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Text(
        "C",
        style: TextStyle(fontSize: 25,color: Colors.red),
      ),
    );
  }
}
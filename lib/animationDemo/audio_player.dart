import 'package:audioplayers/audioplayers.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // 创建一个映射，将字符串映射到音频文件路径
  final Map<String, String> audioPaths = {
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

  Future<void> playAudio(String str) async {
    // 获取对应的音频路径，如果找不到，则使用默认路径
    final audioPath = audioPaths[str] ?? 'audios/${str}.MP3';

    // 如果路径非空，则播放音频
    if (audioPath.isNotEmpty) {
      await _audioPlayer.play(AssetSource(audioPath));
    }
  }
}

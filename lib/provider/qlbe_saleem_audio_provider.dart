import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class QlbeSaleemAudioProvider extends ChangeNotifier {
  final AudioPlayer player = AudioPlayer();
  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  Stream<Duration> get positionStream => player.onPositionChanged;

  Stream<Duration?> get durationStream => player.onDurationChanged;

  QlbeSaleemAudioProvider() {
    player.onPlayerComplete.listen((_) {
      _isPlaying = false;
      notifyListeners();
    });
    player.onPositionChanged.listen((position) {
      print('Position changed: $position');
      _position = position;
      notifyListeners();
    });

    player.onDurationChanged.listen((duration) {
      print('Duration changed: $duration');
      _duration = duration;
      notifyListeners();
    });
  }

  Future<void> playAudio(String audioUrl) async {
    try {
      await player.play(AssetSource(audioUrl));
      _isPlaying = true;
      notifyListeners();
    } catch (e) {
      throw 'Error encounter in play audio method: $e';
    }
  }

  Future<void> pauseAudio() async {
    await player.pause();
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> resumeAudio() async {
    await player.resume();
  }

  Future<void> stopAudio() async {
    await player.stop();
  }

  Future<void> seekAudio(Duration position) async {
    await player.seek(position);
  }

  Future<void> disposeAudio() async {
    await player.dispose();
  }
}

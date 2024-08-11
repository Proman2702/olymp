
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';


class Player {
  Player({required this.file});

  AudioPlayer audio_player = AudioPlayer();

  var file;

  void start() {
    audio_player.play(DeviceFileSource(file.path));
  }
  void pause() {
    audio_player.pause();
  }
  void stop() {
    audio_player.stop();
  }
}
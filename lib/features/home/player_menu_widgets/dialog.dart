import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_app/etc/colors/colors.dart';
import 'package:my_app/features/home/player_menu_widgets/delete_confirmation.dart';
import 'package:my_app/repositories/models/tile_player.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayerDialog extends StatefulWidget {
  final Function updater;
  final TilePlayer tile;
  const PlayerDialog({super.key, required this.updater, required this.tile});

  @override
  State<PlayerDialog> createState() => _PlayerDialogState();
}

class _PlayerDialogState extends State<PlayerDialog> {
  void onDelete() async {
    widget.updater();
    Navigator.pop(context);
    await player.dispose();
  }

  String timeFormat(int seconds) {
    if ("${seconds % 60}".length == 1) {
      return "${seconds ~/ 60}:0${seconds % 60}";
    }
    return "${seconds ~/ 60}:${seconds % 60}";
  }

  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    player.setSourceDeviceFile(widget.tile.file);

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      titlePadding: const EdgeInsets.all(20),
      backgroundColor: Color(CustomColors.dialogBack),
      insetPadding: const EdgeInsets.all(20),
      shadowColor: Colors.black,
      elevation: 5,
      title: Row(
        // Инфа и выход
        children: [
          Container(
            height: 50,
            width: 150,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(CustomColors.main)),
            child: SingleChildScrollView(
              //for horizontal scrolling
              scrollDirection: Axis.horizontal,
              child: Text(
                widget.tile.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(CustomColors.main)),
            child: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => DeleteConfirmDialog(
                            tile: widget.tile,
                            updater: onDelete,
                          ));
                },
                icon: const Icon(
                  Icons.delete,
                  size: 30,
                  color: Colors.white,
                )),
          ),
          const SizedBox(
            width: 12,
          ),
          Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(CustomColors.main)),
            child: IconButton(
                onPressed: () async {
                  await player.dispose();
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                )),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: Color(CustomColors.main),
                    borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                    onPressed: () async {
                      log("Pause");
                      await player.pause();
                    },
                    icon: const Icon(
                      Icons.pause,
                      color: Colors.white,
                      size: 18,
                    )),
              ),
              const SizedBox(width: 10),
              Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(CustomColors.main),
                    borderRadius: BorderRadius.circular(20)),
                child: IconButton(
                  onPressed: () async {
                    log("Playing");
                    await player.play(DeviceFileSource(widget.tile.file));
                  },
                  icon: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: Color(CustomColors.main),
                    borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                    onPressed: () async {
                      log("Stopped");
                      position = Duration.zero;
                      await player.stop();
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.stop,
                      color: Colors.white,
                      size: 18,
                    )),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(timeFormat(position.inSeconds),
                  style: TextStyle(color: Color(CustomColors.main))),
              const SizedBox(width: 200),
              Text(timeFormat(duration.inSeconds),
                  style: TextStyle(color: Color(CustomColors.main))),
            ],
          ),
          SizedBox(height: 5),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              overlayShape: SliderComponentShape.noOverlay,
            ),
            child: Container(
                width: 260,
                alignment: const Alignment(0, 0),
                child: Slider(
                  activeColor: Color(CustomColors.main),
                  thumbColor: Color(CustomColors.main),
                  inactiveColor: Color(CustomColors.shadow),
                  min: 0,
                  max: duration.inSeconds.toDouble() + 1,
                  value: position.inSeconds.toDouble(),
                  onChanged: (value) {
                    final position = Duration(seconds: value.toInt());
                    player.seek(position);
                    player.resume();
                  },
                )),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  List<Widget> list_of_players = [];
  int counter = 0;
  void _add_audio_to_list(PlatformFile file) {
    setState(() {
      counter++;

      AudioPlayer player = AudioPlayer();

      void play_audio(file) {
        player.play(DeviceFileSource(file.path));
      }

      list_of_players.add(const SizedBox(
        height: 20,
      ));
      list_of_players.add(Container(
        height: 80,
        width: 350,
        decoration: const ShapeDecoration(
            color: Color.fromARGB(255, 217, 191, 229),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
        alignment: Alignment.center,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Аудио $counter"),
          Container(
            width: 110,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton(
                onPressed: () => play_audio(file),
                icon: Icon(Icons.play_arrow, color: Colors.white)),
            IconButton(
                onPressed: player.pause,
                icon: Icon(Icons.pause, color: Colors.white)),
            IconButton(
                onPressed: player.stop,
                icon: Icon(Icons.stop, color: Colors.white))
          ]),
        ]),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        toolbarHeight: 70,
        shadowColor: Colors.deepPurple,
        leadingWidth: 100, titleSpacing: 10,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //     bottomLeft: Radius.elliptical(200, 20), bottomRight: Radius.elliptical(200, 20)
        //     )
        // ),
        title: Container(
          padding: const EdgeInsets.all(5),
          child: const Text(
            "Test",
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w800,
                color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 161, 29, 201),
      ),
      body: Center(
          child: Container(
        child: Column(children: <Widget>[Text("анти-бурда")]),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 161, 29, 201),
        onPressed: () {},
        child: const Center(
            child: Text(
          "+",
          textScaler: TextScaler.linear(2.4),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        )),
      ),
    );
  }
}

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:my_app/src/audio_player.dart';


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
      list_of_players.add(const SizedBox(height: 20,));
      list_of_players.add( Container(
            height: 80,
            width: 350,
            decoration: const ShapeDecoration(
              color: Color.fromARGB(255, 217, 191, 229),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
              )
              ), 
            alignment: Alignment.center,
            child: Row(children: [Text("Аудио $counter"), ElevatedButton(onPressed: Player(file: file).start, child: const Text("play"))]),
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
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w800, color: Colors.white),
            ),
          ),
        backgroundColor: const Color.fromARGB(255, 161, 29, 201),
      ),
      body: Center(
        child: Container(
          child: Column(
            children:
              list_of_players
            ),
        )
      ),
      floatingActionButton: FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 161, 29, 201),
      onPressed: () async {
        var picked = await FilePicker.platform.pickFiles();
        if (picked == null) return;

        var file = picked.files.first;


        _add_audio_to_list(file);


      },
      child: const Center(child: Text("+", textScaler: TextScaler.linear(2.4), 
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),)),
      ),
    );    
  }
}
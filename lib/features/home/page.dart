import "package:flutter/material.dart";
import "package:my_app/features/home/add_menu_widgets/dialog.dart";
import "package:my_app/features/home/page_widgets/tile.dart";
import "package:my_app/etc/colors/gradients/appbar.dart";
import "package:my_app/repositories/data_handler.dart";
import "package:my_app/repositories/models/tile_player.dart";
// import "package:file_picker/file_picker.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TilePlayer> tilesList = [];

  @override
  void initState() {
    super.initState();

    tileUpdate();
  }

// апдейт вкладок
  void tileUpdate() async {
    tilesList = await DataHandler().getTiles();
    setState(() {});
  }

// построение страницы
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 4,
          toolbarHeight: 70,
          shadowColor: Colors.deepPurple,
          leadingWidth: 20,
          flexibleSpace:
              Container(decoration: BoxDecoration(gradient: AppbarGrad())),
          title: Container(
            padding: const EdgeInsets.all(5),
            child: const Text(
              "AI App",
              style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/settings");
              },
              icon: const Icon(Icons.settings),
              color: Colors.white,
              iconSize: 35,
            ),
            const SizedBox(width: 10)
          ]),
      body: ListView.builder(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          itemCount: tilesList.length,
          itemBuilder: (context, index) {
            final tile = tilesList[index];
            return TileBuilder(
              index: index,
              updater: tileUpdate,
              tile: tile,
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 161, 29, 201),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  AddDialog(updater: tileUpdate));
        },
        child: const Center(
            child: Icon(
          Icons.upload,
          color: Colors.white,
          size: 30,
        )),
      ),
    );
  }
}

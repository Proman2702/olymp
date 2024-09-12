import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import 'dart:io';
import "package:my_app/etc/colors/colors.dart";
//import "package:my_app/etc/colors/gradients/tile.dart";
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

    for (int i = 0; i < tilesList.length; i++) {
      if (!(File(tilesList[i].file).existsSync())) {
        tileRemove(tilesList[i].name, i);
      }
    }

    setState(() {});
  }

  void tileRemove(String name, int index) async {
    await DataHandler().deleteTile(name);
    tilesList.removeAt(index);
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
          elevation: 5,
          toolbarHeight: 70,
          shadowColor: Colors.black,
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
      body: ListView(
        padding: EdgeInsets.only(left: 22, right: 22, bottom: 22, top: 5),
        children: [
          ListView.builder(
              physics: const ScrollPhysics(),
              padding: EdgeInsets.only(bottom: 15),
              shrinkWrap: true,
              itemCount: tilesList.length,
              itemBuilder: (context, index) {
                final tile = tilesList[index];
                return TileBuilder(
                  index: index,
                  updater: tileUpdate,
                  tile: tile,
                );
              }),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      AddDialog(updater: tileUpdate));
            },
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 3))
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Icon(
                Icons.add_circle_outline,
                size: 40,
                color: Color(CustomColors.shadow),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(CustomColors.bright),
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

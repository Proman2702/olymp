import "package:flutter/material.dart";
import "package:my_app/features/home/tile.dart";
import "package:my_app/src/colors/gradients/appbar.dart";
import "package:my_app/src/colors/gradients/tile.dart";
// import "package:file_picker/file_picker.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int num = 0;
  List<String> playTiles = [];

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Container(
          constraints: const BoxConstraints(),
          decoration: BoxDecoration(gradient: TileGrad())),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

// добавление вкладки (старое)
  // void addTile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //   if (result != null) {
  //     String? file = result.files.single.path!;
  //     playTiles.add("Tile $num with path $file");
  //     num++;
  //     setState(() {});
  //   } else {
  //     // User canceled the picker
  //   }
  // }

// разрабатываемое добавление вкладки
  void addTile(BuildContext context) {
    showAlertDialog(context);
  }

// удаление вкладки
  void removeTile(int index) {
    setState(() {
      playTiles.removeAt(index);
      num--;
    });
  }

// простроение вкладки
  Widget buildTile(int index) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const SizedBox(height: 110),
        ContainerTile(
            num: index,
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: Text(
                  playTiles[index],
                )),
                IconButton(
                    onPressed: () {
                      removeTile(index);
                    },
                    icon: const Icon(Icons.delete))
              ],
            )),
      ],
    );
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
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: AppbarGrad()),
          ),
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
              icon: Icon(Icons.settings),
              color: Colors.white,
              iconSize: 35,
            ),
            const SizedBox(width: 10)
          ]),
      body: ListView.builder(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          itemCount: num,
          itemBuilder: (context, index) => buildTile(index)),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 161, 29, 201),
        onPressed: () {
          addTile(context);
        },
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

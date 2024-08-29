import "package:flutter/material.dart";
import "package:my_app/features/home/tile.dart";
import "package:my_app/src/colors/gradients/appbar.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int num = 0;
  List<String> playTiles = [];

  void addTile() {
    setState(() {
      playTiles.add("Tile $num");
      num++;
    });
  }

  void removeTile(int index) {
    setState(() {
      playTiles.removeAt(index);
      num--;
    });
  }

  Widget buildTile(int index) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const SizedBox(height: 110),
        ContainerTile(
            num: index,
            child: Row(
              children: [
                Text(playTiles[index]),
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
          addTile();
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

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_app/src/colors/gradients/appbar.dart';
import 'package:my_app/features/tiles_list/tile.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      "/": (context) => HomePage(),
      "/settings": (context) => SettingsPage()
    }, title: 'test', theme: ThemeData(fontFamily: 'Nunito'));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> playTiles = [];
  int num = -1;

  void removeTile(n) {
    playTiles.removeAt(n);
    num--;
    setState(() {});
  }

  void addTile() {
    playTiles.add(Column(
      children: [
        ContainerTile(
            num: num,
            child: ElevatedButton(
                onPressed: () {
                  removeTile(this.num);
                },
                child: Text("$num"))),
        SizedBox(height: 20)
      ],
    ));
    num++;
    setState(() {});
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
            SizedBox(width: 10)
          ]),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          children: playTiles,
        )),
      ),
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

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 4,
          toolbarHeight: 70,
          shadowColor: Colors.deepPurple,
          leadingWidth: 50,
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: AppbarGrad()),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
            iconSize: 35,
            color: Colors.white,
          ),
          title: Center(
            child: Container(
              padding: const EdgeInsets.only(right: 30),
              child: const Text(
                "Настройки",
                style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
          )),
    );
  }
}

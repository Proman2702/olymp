import 'package:flutter/material.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
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

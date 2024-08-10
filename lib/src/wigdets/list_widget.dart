import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          color: Colors.orange,
          width: 250,
          height: 50,
          child: Text(
            "привет",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          alignment: Alignment.center,
          color: Colors.orange,
          width: 100,
          height: 20,
          child: Text("бурда"),
        )
      ],
    );
  }
}

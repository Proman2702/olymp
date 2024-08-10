import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';


class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color.fromARGB(255, 161, 29, 201),
      onPressed: () async {
        var picked = await FilePicker.platform.pickFiles();
        if (picked != null) {
          print(picked.files.first.name);
        }
      },
      child: const Center(child: Text("+", textScaler: TextScaler.linear(2.4), 
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),)),
    );
  }
}
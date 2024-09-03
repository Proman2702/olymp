// ignore_for_file: prefer_const_constructors
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_app/features/home/deny_sheet.dart';
import 'package:my_app/etc/colors/colors.dart';
import 'package:my_app/repositories/ai_model.dart';
import 'package:my_app/repositories/data_handler.dart';
import 'package:my_app/repositories/models/tile_player.dart';

class AddDialog extends StatefulWidget {
  final Function func;
  AddDialog({Key? key, required this.func}) : super(key: key);

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  String? fileName;
  int? result = 1;
  String? filePath;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(25),
      backgroundColor: Color(CustomColors.dialogBack),
      insetPadding: EdgeInsets.all(10),
      shadowColor: Colors.black,
      elevation: 5,
      title: Row(
        // Инфа и выход
        children: [
          Container(
            height: 50,
            width: 200,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(CustomColors.main)),
            child: Text(
              "Добавить вкладку",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 19),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(CustomColors.main)),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                )),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                height: 10,
              ),
              // Значок
              Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(CustomColors.mainLightX2)),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.drive_file_rename_outline,
                      size: 24,
                      color: Colors.white,
                    )),
              ),
              SizedBox(width: 15),

              // Поле для ввода
              SizedBox(
                width: 190,
                height: 45,
                child: TextField(
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.black87),
                  onSubmitted: (value) {
                    setState(() {
                      fileName = value;
                    });
                  },
                  maxLength: 16,
                  decoration: InputDecoration(
                    counterText: "",
                    labelText: "Имя вкладки",
                    labelStyle: TextStyle(color: Colors.black45),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(CustomColors.bright)),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                height: 10,
              ),

              // Значок
              Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(CustomColors.mainLightX2)),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.upload,
                      size: 24,
                      color: Colors.white,
                    )),
              ),
              SizedBox(width: 15),

              // Кнопка для загрузки

              GestureDetector(
                  onTap: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();
                    if (result != null) {
                      filePath = result.files.single.path!;
                      setState(() {});
                    } else {
                      // User canceled the picker
                    }
                  },
                  child: Container(
                      height: 40,
                      width: 140,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black12)),
                      child: SingleChildScrollView(
                          child: Text(
                              filePath == null
                                  ? "Загрузка файла"
                                  : filePath!.split("/").last,
                              style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              )))))
            ],
          )
        ],
      ),
      actions: [
        // Кнопка сохранения
        Center(
            child: GestureDetector(
          onTap: () async {
            if (filePath == null || fileName == null) {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) => DenySheet());
            } else {
              result = await AIModel().parser(filePath!);
              TilePlayer tile =
                  TilePlayer(name: fileName!, file: filePath!, result: result!);


              DataHandler().insertTile(tile);

              widget.func();
              Navigator.of(context).pop();
            }
          },
          // Само тело виджета
          child: Container(
              height: 40,
              width: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(CustomColors.main),
                  borderRadius: BorderRadius.circular(15)),
              child: Text("Сохранить",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ))),
        ))
      ],
    );
  }
}

// ignore: unused_import
import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_app/features/home/add_menu_widgets/error_notificator.dart';
import 'package:my_app/etc/colors/colors.dart';
import 'package:my_app/repositories/data_handler.dart';
import 'package:my_app/repositories/models/tile_player.dart';
import 'package:my_app/repositories/upload_to_server.dart';

class AddDialog extends StatefulWidget {
  final Function updater;
  AddDialog({super.key, required this.updater});

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  String? fileName;
  int? result;
  String? filePath;
  String ip = "http://0.tcp.eu.ngrok.io:10964/upload";

  Future<int> get_response(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => SizedBox(
              child: SizedBox(
                height: 20,
                width: 20,
                child: Center(
                    child: CircularProgressIndicator(
                  color: Color(CustomColors.dialogBack),
                )),
              ),
            ));
    try {
      final res = await UploadAudio().uploadAudio(filePath!, ip);
      Navigator.pop(context);
      return res;
    } on Exception catch (e) {
      log("error $e");
      Navigator.pop(context);
      return 400;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            alignment: Alignment(-1, 0.65),
            height: 400,
            width: 400,
            child: Image.asset(
              "images/hexagon.png",
              scale: 1.5,
              opacity: const AlwaysStoppedAnimation(.5),
            )),
        AlertDialog(
          contentPadding: const EdgeInsets.all(25),
          backgroundColor: Color(CustomColors.dialogBack),
          insetPadding: const EdgeInsets.all(10),
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
                child: const Text(
                  "Добавить вкладку",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 19),
                ),
              ),
              const SizedBox(width: 15),
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
                    icon:
                        const Icon(Icons.close, size: 30, color: Colors.white)),
              )
            ],
          ),
          // Главное тело окна
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Ряд с записью названия
              Row(
                children: [
                  const SizedBox(height: 10),

                  // Значок где ввод
                  Container(
                    height: 45,
                    width: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(CustomColors.mainLightX2)),
                    child: const Icon(
                      Icons.drive_file_rename_outline,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 15),

                  // Поле для ввода названия файла
                  SizedBox(
                    width: 190,
                    height: 45,
                    child: TextField(
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.black87),
                      onChanged: (value) {
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
                          borderSide:
                              BorderSide(color: Color(CustomColors.bright)),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),
              // Ряд с выбором файла
              Row(
                children: [
                  const SizedBox(height: 10),
                  // Значок выбора файла
                  Container(
                    height: 45,
                    width: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(CustomColors.mainLightX2)),
                    child: const Icon(
                      Icons.upload,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 15),

                  // Кнопка для загрузки фалйа
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        filePath = result.files.single.path!;
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 140,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black12)),
                      child: SingleChildScrollView(
                        child: Text(
                          filePath == null
                              ? "Загрузка файла"
                              : filePath!.split("/").last,
                          style: const TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),

          // Кнопка сохранения вкладки
          actions: [
            Center(
                child: GestureDetector(
              onTap: () async {
                bool repeated = false;
                final av_names = await DataHandler().getTiles();

                for (final i in av_names) {
                  if (i.name == fileName) {
                    repeated = true;
                    break;
                  }
                }
                // Проверка на наличие введенных данных
                if (filePath == null || fileName == null) {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) =>
                          const DenySheet(type: "none"));
                } else if (filePath!.split(".").last.compareTo("mp3") != 0 &&
                    filePath!.split(".").last.compareTo("wav") != 0) {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) =>
                          DenySheet(type: "format"));
                } else if (repeated) {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) =>
                          DenySheet(type: "repeated"));
                } else {
                  // Запрос
                  final response = await get_response(context);

                  // Сработал ли запрос
                  // нет
                  if (response == 400) {
                    Navigator.of(context).pop();
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) =>
                            DenySheet(type: "response"));
                    // да
                  } else {
                    result = response;
                    TilePlayer tile = TilePlayer(
                        name: fileName!, file: filePath!, result: result!);

                    DataHandler().insertTile(tile);

                    widget.updater();
                    Navigator.of(context).pop();
                  }
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
                  child: const Text("Сохранить",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ))),
            ))
          ],
        ),
      ],
    );
  }
}

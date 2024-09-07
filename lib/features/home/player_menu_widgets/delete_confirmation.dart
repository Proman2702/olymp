import 'package:flutter/material.dart';
import 'package:my_app/etc/colors/colors.dart';
import 'package:my_app/repositories/data_handler.dart';
import 'package:my_app/repositories/models/tile_player.dart';

class DeleteConfirmDialog extends StatelessWidget {
  final TilePlayer tile;
  final Function updater;
  const DeleteConfirmDialog(
      {super.key, required this.tile, required this.updater});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(25),
      backgroundColor: Color(CustomColors.dialogBack),
      insetPadding: const EdgeInsets.all(10),
      shadowColor: Colors.black,
      elevation: 5,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Вы уверены?",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(CustomColors.mainLight),
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  height: 35,
                  width: 100,
                  child: Text(
                    "Да",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                onTap: () async {
                  await DataHandler().deleteTile(tile.name);
                  updater();
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 15,
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(CustomColors.mainLight),
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  height: 35,
                  width: 100,
                  child: Text(
                    "Нет",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                onTap: () => Navigator.pop(context),
              )
            ],
          )
        ],
      ),
    );
  }
}

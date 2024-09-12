import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/etc/colors/colors.dart';
import 'package:my_app/etc/colors/gradients/tile.dart';
import 'package:my_app/features/home/add_menu_widgets/error_notificator.dart';
import 'package:my_app/features/home/player_menu_widgets/dialog.dart';
import 'package:my_app/repositories/data_handler.dart';
//import 'package:my_app/repositories/data_handler.dart';
import 'package:my_app/repositories/models/tile_player.dart';

class TileBuilder extends StatelessWidget {
  final int index;
  final Function updater;
  final TilePlayer tile;
  TileBuilder(
      {super.key,
      required this.index,
      required this.updater,
      required this.tile});

  final List<double> x_align = [-1.2, 1.2];
  final List<double> y_align = [-1.4, 1.4];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
                alignment: Alignment(
                    index % 2 == 0 ? x_align[0] : x_align[1],
                    (index % 4 == 0) || ((index - 1) % 4 == 0)
                        ? y_align[0]
                        : y_align[1]),
                height: 130,
                width: 400,
                child: Image.asset(
                  "images/hexagon.png",
                  scale: 2.5,
                )),
            Container(
                height: 100,
                width: 340,
                decoration: BoxDecoration(
                  gradient: TileGrad(),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 3))
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 275,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                              height: 32,
                              width: 130,
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(CustomColors.main),
                                  borderRadius: BorderRadius.circular(10)),
                              child: SingleChildScrollView(
                                //for horizontal scrolling
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  tile.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: tile.result == 1
                                      ? Icon(
                                          Icons.remove,
                                          color: Color(CustomColors.bright),
                                          size: 20,
                                        )
                                      : Icon(Icons.done,
                                          color: Color(CustomColors.bright),
                                          size: 20)),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                tile.result == 1
                                    ? "Обнаружен дефект речи"
                                    : "Дефектов нет",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                        onTap: () async {
                          if (File(tile.file).existsSync()) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) =>
                                  PlayerDialog(updater: updater, tile: tile),
                            );
                          } else {
                            await DataHandler().deleteTile(tile.name);
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) =>
                                    const DenySheet(type: "not_found"));
                            updater();
                          }
                        },
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              height: 32,
                              width: 40,
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(CustomColors.main),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Icon(
                                Icons.more_horiz,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        )),
                  ],
                )),
          ],
        ),
      ],
    );
  }
}

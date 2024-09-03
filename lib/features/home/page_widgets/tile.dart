import 'package:flutter/material.dart';
import 'package:my_app/etc/colors/gradients/tile.dart';
import 'package:my_app/repositories/data_handler.dart';
import 'package:my_app/repositories/models/tile_player.dart';

class TileBuilder extends StatelessWidget {
  final int index;
  final Function func;
  final TilePlayer tile;
  const TileBuilder(
      {super.key, required this.index, required this.func, required this.tile});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const SizedBox(
          height: 110,
          width: 110,
        ),
        const SizedBox(
          height: 100,
          width: 100,
          child: Image(
            image: AssetImage('assets/img/hexagon.png'),
            height: 100,
            width: 100,
          ),
        ),
        Container(
            alignment: const Alignment(0.9, 0),
            height: 90,
            width: 340,
            decoration: BoxDecoration(
              gradient: TileGrad(),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Flexible(child: Text(tile.name)),
                IconButton(
                    onPressed: () async {
                      await DataHandler().deleteTile(tile.name);

                      func();
                    },
                    icon: const Icon(Icons.delete))
              ],
            )),
      ],
    );
  }
}

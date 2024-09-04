import 'package:flutter/material.dart';
import 'package:my_app/etc/colors/colors.dart';
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
        const SizedBox(height: 110, width: 110),
          
         

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
                const SizedBox(width: 12),
                Column(children: [
                  SizedBox(height: 12,),
                  Flexible(child: Container(
                    height: 32,
                    width: 130,
                    padding: EdgeInsets.only(left: 5, right: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Color(CustomColors.main), borderRadius: BorderRadius.circular(10)),
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
                    )

                  ))
                  
                ],),
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

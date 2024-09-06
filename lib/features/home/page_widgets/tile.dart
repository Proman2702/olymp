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
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
        
          children: [
            SizedBox(height: 110, width: 110, 
            child: Image.asset("images/hexagon.png")),
              
             
        
            Container(
                alignment: const Alignment(0.9, 0),
                height: 100,
                width: 340,
                decoration: BoxDecoration(
                  gradient: TileGrad(),
                  boxShadow: [BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 3)
                  )],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [
                    const SizedBox(width: 12),
                    SizedBox(width: 275, child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      SizedBox(height: 12,),
                      Container(
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
        
                      ),
        
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        
                        children: [
                          Container(height: 25, width: 25, decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child:
                            tile.result == 1 ? 
                              Icon(Icons.remove, color: Color(CustomColors.bright), size: 20,) :
                              Icon(Icons.done, color: Color(CustomColors.bright), size: 20)),
                          const SizedBox(width: 12,),
                          Text(
                            tile.result == 1 ? "Обнаружен дефект речи" : "Дефектов нет"
                            ,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ],)
                    ],
                    ),),
                    
                    
                    GestureDetector(
                         onTap: () async {
                           await DataHandler().deleteTile(tile.name);
        
                           func();
                         },
                         child: Column(
                           children: [
                            SizedBox(height: 12,),
                             Container(height: 32,
                                                     width: 40,
                                                     padding: EdgeInsets.only(left: 5, right: 5),
                                                     alignment: Alignment.center,
                                                     child: Icon(Icons.more_horiz, color: Colors.white, size: 30,),
                                                     decoration: BoxDecoration(color: Color(CustomColors.main), borderRadius: BorderRadius.circular(10)),),
                           ],
                         )),
                        
                  ],
                )),
          
         
          ],
        ),
        SizedBox(height: 10,)
      ],
    );
  }
}

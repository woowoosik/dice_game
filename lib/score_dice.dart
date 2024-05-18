import 'package:dice_game/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ScoreDice extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ScoreDice();
  }
}

class _ScoreDice extends State<ScoreDice>{

  var controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(
        builder: (_){
          return Row(
            children: [
              for(var i=0; i<5; i++)...[
                Image.asset(
                  dice(controller.list[i]),
                  width: 60,
                  height: 60,
                ),
              ]
            ],
          );
        }
    );
  }
}

String dice(int diceImage) {
  if(diceImage == 1){
    return 'assets/dice1.png';
  }else if(diceImage == 2){
    return 'assets/dice2.png';
  }else if(diceImage == 3){
    return 'assets/dice3.png';
  }else if(diceImage == 4){
    return 'assets/dice4.png';
  }else if(diceImage == 5){
    return 'assets/dice5.png';
  }else{
    return 'assets/dice6.png';
  }
}
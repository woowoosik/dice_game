import 'dart:math';

import 'package:dice_game/controller.dart';
import 'package:dice_game/cube.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger_plus/logger_plus.dart';

class Dice extends StatefulWidget {

  final int x;
  final int y;
  final int index;

  Dice({super.key, required this.x, required this.y, required this.index});

  @override
  State<StatefulWidget> createState() {
    return _Dice();
  }
}

class _Dice extends State<Dice> with TickerProviderStateMixin {
  final double _size = 50.0;

  double _x = pi * 0.25;
  double _y = pi * 0.25;

  var xx = 0;
  var yy = 0;

  var xPos = 150;
  var yPos = 300;
  var xVec = 1;
  var yVec = 1;/*
  var mapXsize = 300.0;
  var mapYsize = 600.0;*/
  var xSpeed = 5;
  var ySpeed = 5;

  var padding = 0.07;

  late AnimationController animationController;
  late Animation<double> animationX;
  late Animation<double> animationY;

 /* late AnimationController moveAnimationController;
  late Animation<double> moveAnimationX;
  late Animation<double> moveAnimationY;*/

  var diceClick = false;
  double beginX = Random().nextDouble() * pi * 2;
  double beginY = Random().nextDouble() * pi * 2;

  double endX = Random().nextDouble() * pi * 2;
  double endY = Random().nextDouble() * pi * 2;

/*

  double moveBeginX = Random().nextDouble() * pi * 2;
  double moveBeginY = Random().nextDouble() * pi * 2;

  double moveEndX = Random().nextDouble() * pi * 2;
  double moveEndY = Random().nextDouble() * pi * 2;
*/

  var width = 0;
  var height = 0;


  var controller = Get.put(Controller());

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(microseconds: 1000000),
      vsync: this,
    );

    animationX =
        Tween<double>(begin: beginX, end: endX).animate(animationController);
    animationY =
        Tween<double>(begin: beginY, end: endY).animate(animationController);

/*

    moveAnimationController = AnimationController(
      duration: const Duration(microseconds: 1000000),
      vsync: this,
    );

    moveAnimationX =
        Tween<double>(begin: moveBeginX, end: moveEndX).animate(moveAnimationController);
    moveAnimationY =
        Tween<double>(begin: moveBeginY, end: moveEndY).animate(moveAnimationController);

*/

    super.initState();
  }

  var mapXsize;
  var mapYsize;

  @override
  Widget build(BuildContext context) {

    mapXsize = MediaQuery.sizeOf(context).width ;
    mapYsize = MediaQuery.sizeOf(context).height * 0.75;


    Logger().d('map size  $mapXsize  $mapYsize');
    animationController.addListener(() {
      setState(() {
      });
    });
   /* moveAnimationController.addListener(() {
      if (moveAnimationX.value *20 >= mapXsize ) {
        Logger().e("moveAnimationController _diceWidth 1 ${mapXsize} <= ${moveAnimationX.value *20}  ${moveAnimationController.value}");

   *//*   moveAnimationController.repeat();

      int s = (1000000 - (moveAnimationController.value*1000000).toInt());
        moveAnimationController = AnimationController(
          duration: Duration(microseconds: s),
          vsync: this,
        );



        moveAnimationX =
          Tween<double>(begin: mapXsize, end: moveEndX - mapXsize).animate(moveAnimationController);
      moveAnimationY =
          Tween<double>(begin: moveAnimationY.value, end: endY).animate(moveAnimationController);

      moveAnimationController.forward();
*//*
      }
      if (moveAnimationX.value *20 <= _size ) {
        Logger().e("moveAnimationController _diceWidth 2 ${_size} >= ${moveAnimationX.value *20}   ${moveAnimationController.value}");

      }

      setState(() {

      });
    });
*/
    return Stack(children: <Widget>[
      // Cube
      GestureDetector(
        onDoubleTap: () {
          animationController.repeat();
          animationController.reset();
     /*     moveAnimationController.repeat();
          moveAnimationController.reset();*/
          Logger().d("onTap");
          setState(() {
            Logger().d('$beginX  $beginY');

            endX = Random().nextDouble() * pi * 6;
            endY = Random().nextDouble() * pi * 6;

            Logger().d('end nomal value : $endX  $endY');

            Logger().e('end nomal value % : 1:  0 ~ 0.7535 || 5.5265 ~ 6.28 ');
            Logger().e('end nomal value % : 6:  2.3235 ~ 3.89 ');
            Logger().e(
                'end nomal value % : ${endX % (pi * 2)}  ${endY % (pi * 2)}');

            var s = front(endX % (pi * 2), endY % (pi * 2),
                (-(pi / 2) + endY) % (pi * 2));

            //var controller = Get.put(Controller());
            Logger().d('${widget.index}/ 15');
            controller.changeDice(widget.index , s);
            // var s= diceFront(widget.x,widget.y,-_halfPi + widget.y, _topBottom, _northSouth, _eastWest);

            if (s == 1) {
              Logger().e('end 1 : ${endX % (pi * 2)}  ${endY % (pi * 2)}');
              if (0 <= endX % (pi * 2) && endX % (pi * 2) < (pi / 2) / 2) {
                endX = endX - endX % (pi * 2) + pi * 2 + padding;
              } else {
                endX = endX - endX % (pi * 2) + pi * 2 - padding;
              }
              // x 0
            } else if (s == 6) {
              Logger().e('end 6 : ${endX % (pi * 2)}  ${endY % (pi * 2)}');
              if (endX <= pi) {
                endX = endX - endX % (pi * 2) + pi + pi * 2 - padding;
              } else {
                endX = endX - endX % (pi * 2) + pi + pi * 2 + padding;
              }
            } else {
              Logger().e('end else : $s');

              endX = endX - endX % (pi * 2) + pi * 2;
              if (0 <= endX % (pi * 2) && endX % (pi * 2) < pi - (pi / 2)) {
                endX += (pi / 2 - padding);
                //animationX = Tween<double>(begin: beginX, end: pi/2-padding).animate(animationController);
              } else if (pi / 2 <= endX % (pi * 2) &&
                  endX % (pi * 2) < pi + pi / 2) {
                endX += (pi / 2 + padding);
                //animationX = Tween<double>(begin: beginX, end: pi/2+padding).animate(animationController);
              } else if (pi + pi / 2 <= endX % (pi * 2) &&
                  endX % (pi * 2) < pi + pi + pi / 2) {
                endX += (pi + pi / 2 + padding);
                //animationX = Tween<double>(begin: beginX, end: pi + pi/2+padding).animate(animationController);
              } else if (pi + 0 <= endX % (pi * 2) &&
                  endX % (pi * 2) < pi + pi - (pi / 2)) {
                endX += (pi + pi / 2 - padding);
                //animationX = Tween<double>(begin: beginX, end: pi + pi/2-padding).animate(animationController);
              }

              if (s == 2) {
                Logger().e(
                    'end 2 : ${endX % (pi * 2)}  ${endY % (pi * 2)}  ${endY + endY % (pi * 2) + pi}');
                // y 0
                if (endY < pi) {
                  endY = endY - endY % (pi * 2) + pi * 2 + padding;
                } else {
                  endY = endY - endY % (pi * 2) + pi * 2 - padding;
                }
              } else if (s == 3) {
                Logger().e(
                    'end 3 : ${endX % (pi * 2)}  ${endY % (pi * 2)} ${endY + endY % (pi * 2) + pi + pi / 2}');
                // pi/2
                if (endY <= pi / 2) {
                  endY = endY - endY % (pi * 2) + pi / 2 + pi * 2 - padding;
                } else {
                  endY = endY - endY % (pi * 2) + pi / 2 + pi * 2 + padding;
                }
              } else if (s == 4) {
                Logger().e(
                    'end 4 : ${endX % (pi * 2)}  ${endY % (pi * 2)}  ${endY + endY % (pi * 2) + pi / 2}');
                // pi3/2
                if (endY <= (pi + pi / 2)) {
                  endY =
                      endY - endY % (pi * 2) + pi + pi / 2 + pi * 2 - padding;
                } else {
                  endY =
                      endY - endY % (pi * 2) + pi + pi / 2 + pi * 2 + padding;
                }
              } else if (s == 5) {
                Logger().e(
                    'end 5 : ${endX % (pi * 2)}  ${endY % (pi * 2)} ${endY + endY % (pi * 2)}');
                //pi
                if (endY <= pi) {
                  endY = endY - endY % (pi * 2) + pi + pi * 2 - padding;
                } else {
                  endY = endY - endY % (pi * 2) + pi + pi * 2 + padding;
                }
              }
            }

            animationX = Tween<double>(begin: beginX, end: endX)
                .animate(animationController);
            animationY = Tween<double>(begin: beginY, end: endY)
                .animate(animationController);


         /*   moveAnimationY =
                Tween<double>(begin: beginX, end: endX).animate(moveAnimationController);
            moveAnimationX =
                Tween<double>(begin: beginY, end: endY).animate(moveAnimationController);
*/

            beginX = endX;
            beginY = endY;

            if (animationController.isDismissed) {
              animationController.forward();
             // moveAnimationController.forward();
            } else if (animationController.isCompleted) {
              animationController.forward();
             // moveAnimationController.forward();
            } else {
              Logger().e('else');
            }
          });
        },
        /*         onPanUpdate: (DragUpdateDetails u) => setState((){
                      _x = (_x + -u.delta.dy / 150) % (pi * 2);
                      _y = (_y + -u.delta.dx / 150) % (pi * 2);
                    }),*/
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            _diceWidth(animationY.value * 25 + widget.x) - _size,
            _diceHeight(animationX.value * 45 + widget.y) - _size,
            mapXsize - _diceWidth(animationY.value * 25 + widget.x),
            mapYsize - _diceHeight(animationX.value * 45 + widget.y),
          ),
          child: Container(
            /*  height: _diceHeight(animationX.value * 20),*/
           // width: _diceWidth(animationY.value * 20),
            child: Cube(
              x: (animationX.value) % (pi * 2),
              y: (animationY.value) % (pi * 2),
              /*     x: (_x) % (pi * 2),
                            y: (_y) % (pi * 2),*/
              size: _size,
            ),
          ),
        ),



      ),
    ]);




  }

  dynamic _diceWidth(dynamic y) {
    Logger().d("_diceWidth ${y} >= ${(mapXsize - _size )}");
    Logger().d("_diceWidth ${mapXsize} ");
    if (y >= (mapXsize )) {
      Logger().d("_diceWidth 1 ${mapXsize}  ");
     // var w = mapXsize - (y - mapXsize);
      return mapXsize - (y - mapXsize);
    }else if (y < _size ) {
      Logger().d("_diceWidth 2 ${mapXsize + _size}   ");
      //var w = _size - y;
      return _size - y + _size;
      //return _size ;
    }else{
      Logger().d("_diceWidth 3 ${y}");
      return y;
    }

  }

  dynamic _diceHeight(dynamic x) {
    Logger().d("_diceHeight ${x} >= ${(mapYsize - _size )}");
    Logger().d("_diceHeight ${mapYsize}  ");
    if (x >= (mapYsize )) {
      Logger().d("_diceHeight 1 ${mapYsize} ${mapYsize - ( x - mapYsize)} ");
      return mapYsize - ( x - mapYsize);
    }
    if (x <= _size ) {
      Logger().d("_diceHeight 2 ${mapYsize + _size}  ");
      return _size -x +_size ;
    }

    Logger().d("_diceHeight 3 $x");
    return x;
  }
}

int front(double x, double y, double z) {
  double _halfPi = pi / 2;
  double _oneHalfPi = pi + pi / 2;

  var yy = y % pi;
  var zz = z % pi;

  var frontY = min((pi - yy).abs(), yy);
  var frontZ = min((pi - zz).abs(), zz);

  var sum = (y + (x > pi ? pi : 0.0)).abs() % (pi * 2);
  /*  final bool _northSouth = sum < _halfPi || sum > _oneHalfPi;
    final bool _eastWest = sum < pi;
     final bool _northSouth = widget._sum < _halfPi || widget._sum > _oneHalfPi;
    final bool _eastWest = widget._sum < pi;
    */

  var m = min(frontY, frontZ);
  if (0 <= x && x < _halfPi / 2 || (pi * 2 - _halfPi / 2) <= x && x < pi * 2) {
    return 1;
  } else if (_halfPi + _halfPi / 2 <= x && x < pi + _halfPi / 2) {
    return 6;
  } else {
    if (m == frontY) {
      if (sum < _halfPi || sum > _oneHalfPi) {
        return 2;
      } else {
        return 5;
      }
    } else {
      if (sum < pi) {
        return 3;
      } else {
        return 4;
      }
    }
  }
}
import 'dart:async';
import 'dart:ffi';
import 'dart:math';
import 'package:dice_game/board.dart';
import 'package:dice_game/score_dice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger_plus/logger_plus.dart';

import 'dice.dart';

void main() => runApp(
    GetMaterialApp(
        home:
        Scaffold(
            body: Column(
              children: [
                // Expanded(child: Board(),),
                Board(),
                ScoreDice(),
              ],
            ),
        )
    )
);

num map(num value,
        [num iStart = 0, num iEnd = pi * 2, num oStart = 0, num oEnd = 1.0]) =>
    ((oEnd - oStart) / (iEnd - iStart)) * (value - iStart) + oStart;

class CreateApp extends StatefulWidget {
  @override
  CreateAppState createState() => CreateAppState();
}

class CreateAppState extends State<CreateApp> with TickerProviderStateMixin {
  final List<Widget> _list = <Widget>[];
  final double _size = 50.0;

  double _x = pi * 0.25;
  double _y = pi * 0.25;
  Timer? _timer;

  var xx = 0;
  var yy = 0;

  var xPos = 150;
  var yPos = 300;
  var xVec = 1;
  var yVec = 1;
  var mapXsize = 800;
  var mapYsize = 800;
  var xSpeed = 5;
  var ySpeed = 5;

  var padding = 0.07;

  int get size => _list.length;
  late AnimationController animationController;

  late Animation<double> animationX;
  late Animation<double> animationY;

  late AnimationController moveAnimationController;

  var diceClick = false;
  double beginX = Random().nextDouble() * pi * 2;
  double beginY = Random().nextDouble() * pi * 2;

  double endX = Random().nextDouble() * pi * 2;
  double endY = Random().nextDouble() * pi * 2;

  var width = 0;
  var height = 0;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    animationX =
        Tween<double>(begin: beginX, end: endX).animate(animationController);
    animationY =
        Tween<double>(begin: beginY, end: endY).animate(animationController);

    /*   moveAnimationController = AnimationController(
      duration: const Duration(milliseconds:500),
      vsync: this,
    );


*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    animationController.addListener(() {
      setState(() {});
    });

    return /*SafeArea(
        child: Column(
          children: [
            for(var i =0; i<5; i++)...[

              SizedBox(height: 40,),
            */
        Container(
      color: Colors.redAccent,
      height: 800,
      width: 800,
      child: Stack(children: <Widget>[
        /* // Rainbow
                  LayoutBuilder(
                      builder: (_, BoxConstraints c) =>
                          Stack(
                              children: _list.map((Widget w) {
                                final num _i = map(size - _list.indexOf(w), 0, 150);

                                return Positioned(
                                    top: (c.maxHeight / 2 - _size / 2) + _i * c.maxHeight * 0.9,
                                    left: (c.maxWidth / 2 - _size / 2) - _i * c.maxWidth * 0.9,
                                    child: Transform.scale(scale: _i * 1.5 + 1.0, child: w));
                              }).toList()
                          )
                  ),
*/
        // Cube
        GestureDetector(
          onDoubleTap: () {
            animationController.reset();
            Logger().d("onTap");
            setState(() {
              Logger().d('$beginX  $beginY');

              endX = Random().nextDouble() * pi * 7;
              endY = Random().nextDouble() * pi * 7;

              Logger().d('end nomal value : $endX  $endY');

              Logger()
                  .e('end nomal value % : 1:  0 ~ 0.7535 || 5.5265 ~ 6.28 ');
              Logger().e('end nomal value % : 6:  2.3235 ~ 3.89 ');
              Logger().e(
                  'end nomal value % : ${endX % (pi * 2)}  ${endY % (pi * 2)}');

              var s = front(endX % (pi * 2), endY % (pi * 2),
                  (-(pi / 2) + endY) % (pi * 2));
              // var s= diceFront(widget.x,widget.y,-_halfPi + widget.y, _topBottom, _northSouth, _eastWest);

              /*       if(0 <= endX%(pi * 2) && endX%(pi * 2) < pi - (pi/2)){
                          endX = (pi/2-padding);
                          //animationX = Tween<double>(begin: beginX, end: pi/2-padding).animate(animationController);
                        }else if(pi/2 <= endX%(pi * 2) && endX%(pi * 2) < pi + pi/2){
                          endX = (pi/2+padding);
                          //animationX = Tween<double>(begin: beginX, end: pi/2+padding).animate(animationController);
                        }else if(pi + pi/2 <= endX%(pi * 2) && endX%(pi * 2) < pi + pi + pi/2){
                          endX = (pi + pi/2+padding);
                          //animationX = Tween<double>(begin: beginX, end: pi + pi/2+padding).animate(animationController);
                        }else if(pi + 0 <= endX%(pi * 2) && endX%(pi * 2) < pi + pi - (pi/2)){
                          endX = (pi + pi/2-padding);
                          //animationX = Tween<double>(begin: beginX, end: pi + pi/2-padding).animate(animationController);
                        }

                        if(s == 1){
                          endX = padding;
                          animationX = Tween<double>(begin: beginX, end: padding).animate(animationController);
                          animationY = Tween<double>(begin: beginY, end: endY).animate(animationController);
                        }else if(s == 6){
                          endX = pi + padding;
                          animationX = Tween<double>(begin: beginX, end: pi+padding).animate(animationController);
                          animationY = Tween<double>(begin: beginY, end: endY).animate(animationController);
                        }else if( s == 2){
                          endY = padding;
                         // animationY = Tween<double>(begin: beginY, end: padding).animate(animationController);
                        }else if( s == 3){
                          endY = pi/2 + padding;
                         // animationY = Tween<double>(begin: beginY, end: pi/2 + padding).animate(animationController);
                        }else if( s == 4){
                          endY = pi + pi/2 + padding;
                         // animationY = Tween<double>(begin: beginY, end: pi + pi/2 + padding).animate(animationController);
                        }else if( s == 5){
                          endY = pi + padding;
                         // animationY = Tween<double>(begin: beginY, end: pi + padding).animate(animationController);
                        }
                */

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
              beginX = endX;
              beginY = endY;

              if (animationController.isDismissed) {
                animationController.forward();
              } else if (animationController.isCompleted) {
                animationController.forward();
              } else {
                Logger().e('else');
              }
            });
          },
          /*         onPanUpdate: (DragUpdateDetails u) => setState((){
                      _x = (_x + -u.delta.dy / 150) % (pi * 2);
                      _y = (_y + -u.delta.dx / 150) % (pi * 2);
                    }),*/
          child: SizedBox(
            width: _diceWidth(animationY.value * 25),
            height: _diceHeight(animationX.value * 25),
            child: Cube(
              color: Colors.grey.shade200,
              x: (animationX.value) % (pi * 2),
              y: (animationY.value) % (pi * 2),
              /*     x: (_x) % (pi * 2),
                          y: (_y) % (pi * 2),*/
              size: _size,
            ),
          ),
        ),
      ]),
    )
        /*        ]
          ],
        )
    );
*/

        ;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _start() {
    if (_timer?.isActive ?? false) {
      return;
    }

    _timer = Timer.periodic(Duration(milliseconds: 48), (_) => _add());
  }

  void _add() {
    if (size > 150)
      _list.removeRange(
          0, Colors.accents.length * 4); // Expensive, remove more at once

    setState(() => _list.add(Cube(
        /*
      animationX: animationX,
        animationY: animationY,*/
        x: _x,
        y: _y,
        color: Colors.accents[_timer!.tick % Colors.accents.length]
            .withOpacity(0.2),
        size: _size)));
  }

  dynamic _dice() {
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          var s = animationController.value * 800;
          if (animationX.value >= (mapXsize - _size) ||
              animationX.value <= _size) {
            var endx = (endX.abs() - (animationX.value).abs()).abs();
            var endy = (endY.abs() - (animationY.value).abs()).abs();
            animationX = Tween<double>(begin: animationX.value, end: endx)
                .animate(animationController);
            animationY = Tween<double>(begin: animationY.value, end: endy)
                .animate(animationController);
          }
          if (animationY.value >= (mapYsize - _size) ||
              animationX.value <= _size) {
            var endx = (endX.abs() - (animationX.value).abs()).abs();
            var endy = (endY.abs() - (animationY.value).abs()).abs();
            animationX = Tween<double>(begin: animationX.value, end: endx)
                .animate(animationController);
            animationY = Tween<double>(begin: animationY.value, end: endy)
                .animate(animationController);

            animationController.repeat();
          }
        });
      }
    });
  }

  dynamic _diceWidth(dynamic y) {
    Logger().d("_diceWidth ${y}");
    if (y >= (mapYsize - _size - 50.0)) {
      return mapYsize - 50.0;
    }
    if (y <= _size + 50.0) {
      return _size + 50.0;
    }

    return y;
  }

  dynamic _diceHeight(dynamic x) {
    Logger().d("_diceHeight ${x}");
    if (x >= (mapXsize - _size - 50.0)) {
      return mapXsize - 50.0;
    }
    if (x <= _size + 50.0) {
      return _size + 50.0;
    }

    return x;
  }
}

class Cube extends StatefulWidget {
  final double x, y, size;
  final Color color;

  double get _sum => (y + (x > pi ? pi : 0.0)).abs() % (pi * 2);

  const Cube({
    Key? key,
    required this.x,
    required this.y,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Cube();
  }
}

class _Cube extends State<Cube> with TickerProviderStateMixin {
  static const double _shadow = 0.2;
  static const double _halfPi = pi / 2;
  static const double _oneHalfPi = pi + pi / 2;

  @override
  Widget build(BuildContext context) {
    final bool _topBottom = widget.x < _halfPi || widget.x > _oneHalfPi;
    final bool _northSouth = widget._sum < _halfPi || widget._sum > _oneHalfPi;
    final bool _eastWest = widget._sum < pi;

    //Logger().d('${widget.x}   ${widget.y}   ${-_halfPi + widget.y}');

    //diceFront(widget.x,widget.y,-_halfPi + widget.y, _topBottom, _northSouth, _eastWest);
    // diceFront(widget.x,widget.y,-_halfPi + widget.y, _topBottom, _northSouth, _eastWest);
    Logger().d(
        '${diceFront(widget.x, widget.y, -_halfPi + widget.y, _topBottom, _northSouth, _eastWest)}');

    // Logger().d('${_topBottom}   $_northSouth   $_eastWest');
    return Stack(children: <Widget>[
      _side(
          zRot: widget.y,
          xRot: -widget.x,
          shadow: _getShadow(widget.x).toDouble(),
          diceImage: 1,
          moveZ: _topBottom),
      _side(
          yRot: widget.y,
          xRot: _halfPi - widget.x,
          shadow: _getShadow(widget._sum).toDouble(),
          diceImage: 2,
          moveZ: _northSouth),
      _side(
          yRot: -_halfPi + widget.y,
          xRot: _halfPi - widget.x,
          shadow: _shadow - _getShadow(widget._sum),
          diceImage: 3,
          moveZ: _eastWest)
    ]);
  }

  num _getShadow(double r) {
    if (r < _halfPi) {
      return map(r, 0, _halfPi, 0, _shadow);
    } else if (r > _oneHalfPi) {
      return _shadow - map(r, _oneHalfPi, pi * 2, 0, _shadow);
    } else if (r < pi) {
      return _shadow - map(r, _halfPi, pi, 0, _shadow);
    }

    return map(r, pi, _oneHalfPi, 0, _shadow);
  }

  Widget _side({
    bool moveZ = true,
    double xRot = 0.0,
    double yRot = 0.0,
    double zRot = 0.0,
    double shadow = 0.0,
    int diceImage = 1,
  }) {
    Logger().d('${xRot}  $yRot  $zRot');

    return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..rotateX(xRot)
          ..rotateY(yRot)
          ..rotateZ(zRot)
          ..translate(0.0, 0.0, moveZ ? -widget.size / 2 : widget.size / 2),
        child: Container(
            alignment: Alignment.center,
            child: Container(
              constraints: BoxConstraints.expand(
                  width: widget.size, height: widget.size),
              child: dice(diceImage, moveZ),
            )));
  }

  Image dice(int diceImage, bool move) {
    if (move) {
      if (diceImage == 1) {
        return Image.asset('assets/dice1.png');
      } else if (diceImage == 2) {
        return Image.asset('assets/dice2.png');
      } else {
        return Image.asset('assets/dice3.png');
      }
    } else {
      if (diceImage == 1) {
        return Image.asset('assets/dice6.png');
      } else if (diceImage == 2) {
        return Image.asset('assets/dice5.png');
      } else {
        return Image.asset('assets/dice4.png');
      }
    }
  }

  int diceFront(double x, double y, double z, bool bx, bool by, bool bz) {
    var yy = y % pi;
    var zz = z % pi;

    var frontY = min((pi - yy).abs(), yy);
    var frontZ = min((pi - zz).abs(), zz);

    var m = min(frontY, frontZ);
    if (0 <= x && x < _halfPi / 2 ||
        (pi * 2 - _halfPi / 2) <= x && x < pi * 2) {
      return 1;
    } else if (_halfPi + _halfPi / 2 <= x && x < pi + _halfPi / 2) {
      return 6;
    } else {
      if (m == frontY) {
        if (by) {
          return 2;
        } else {
          return 5;
        }
      } else {
        if (bz) {
          return 3;
        } else {
          return 4;
        }
      }
    }
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

/*

class Cube extends StatelessWidget {
  static const double _shadow = 0.2;
  static const double _halfPi = pi / 2;
  static const double _oneHalfPi = pi + pi / 2;

  final double x, y, size;
  final Color color;
  final bool rainbow;

  double get _sum => (y + (x > pi ? pi : 0.0)).abs() % (pi * 2);

  const Cube(
      {Key? key,
        required this.animationX,
        required this.animationY,

      required this.x,
      required this.y,
      required this.color,
      required this.size,
      this.rainbow = false,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _topBottom = x < _halfPi || x > _oneHalfPi;
    final bool _northSouth = _sum < _halfPi || _sum > _oneHalfPi;
    final bool _eastWest = _sum < pi;

    Logger().d('${_topBottom}   $_northSouth   $_eastWest');
    return Stack(children: <Widget>[
      _side(
          zRot: y,
          xRot: -x,
          shadow: _getShadow(x).toDouble(),
          diceImage: 1,
          moveZ: _topBottom),
      _side(
          yRot: y,
          xRot: _halfPi - x,
          shadow: _getShadow(_sum).toDouble(),
          diceImage: 2,
          moveZ: _northSouth),
      _side(
          yRot: -_halfPi + y,
          xRot: _halfPi - x,
          shadow: _shadow - _getShadow(_sum),
          diceImage: 3,
          moveZ: _eastWest)
    ]);
  }

  num _getShadow(double r) {
    if (r < _halfPi) {
      return map(r, 0, _halfPi, 0, _shadow);
    } else if (r > _oneHalfPi) {
      return _shadow - map(r, _oneHalfPi, pi * 2, 0, _shadow);
    } else if (r < pi) {
      return _shadow - map(r, _halfPi, pi, 0, _shadow);
    }

    return map(r, pi, _oneHalfPi, 0, _shadow);
  }

  Widget _side(
      {bool moveZ = true,
      double xRot = 0.0,
      double yRot = 0.0,
      double zRot = 0.0,
      double shadow = 0.0,
      int diceImage = 1,
      }) {

    Logger().d('${xRot}  $yRot  $zRot');
    return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..rotateX(xRot)
          ..rotateY(yRot)
          ..rotateZ(zRot)
          ..translate(0.0, 0.0, moveZ ? -size / 2 : size / 2),
        child: Container(
            alignment: Alignment.center,
            child: Container(
                constraints: BoxConstraints.expand(width: size, height: size),
                child: dice(diceImage, moveZ),
  color: color,
                foregroundDecoration: BoxDecoration(
                    color: Colors.black.withOpacity(rainbow ? 0.0 : shadow),
                    border: Border.all(
                        width: 0.8,
                        color: rainbow
                            ? color.withOpacity(0.3)
                            : Colors.black26))

            )));
  }

  Image dice(int diceImage, bool move){
    if(move){
      if(diceImage == 1){
        return Image.asset('assets/dice1.png');
      }else if(diceImage == 2){
        return Image.asset('assets/dice2.png');
      }else{
        return Image.asset('assets/dice3.png');
      }

    }else{
      if(diceImage == 1){
        return Image.asset('assets/dice6.png');
      }else if(diceImage == 2){
        return Image.asset('assets/dice5.png');
      }else{
        return Image.asset('assets/dice4.png');
      }
    }

  }




}
*/

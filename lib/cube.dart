
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:logger_plus/logger_plus.dart';

import 'main.dart';

num map(num value,
    [num iStart = 0, num iEnd = pi * 2, num oStart = 0, num oEnd = 1.0]) =>
    ((oEnd - oStart) / (iEnd - iStart)) * (value - iStart) + oStart;


class Cube extends StatefulWidget{


  final double x, y, size;

  double get _sum => (y + (x > pi ? pi : 0.0)).abs() % (pi * 2);


  const Cube(
      {Key? key,
        required this.x,
        required this.y,
        required this.size,
      })
      : super(key: key);

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
    Logger().d('${diceFront(widget.x,widget.y,-_halfPi + widget.y, _topBottom, _northSouth, _eastWest)}');


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
          ..translate(0.0, 0.0, moveZ ? -widget.size / 2 : widget.size / 2),
        child: Container(
            alignment: Alignment.center,
            child: Container(
              constraints: BoxConstraints.expand(width: widget.size, height: widget.size),
              child: dice(diceImage, moveZ),


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


  int diceFront(double x, double y, double z, bool bx, bool by, bool bz){

    var yy = y%pi;
    var zz = z%pi;

    var frontY = min((pi - yy).abs(), yy);
    var frontZ = min((pi - zz).abs(), zz);


    var m = min(frontY,frontZ);
    if(0 <= x && x<_halfPi/2 || (pi*2 - _halfPi/2) <= x && x< pi*2){
      return 1;
    }else if(_halfPi + _halfPi/2 <= x && x< pi + _halfPi/2){
      return 6;
    }else{
      if(m == frontY) {
        if(by){
          return 2;
        }else{
          return 5;
        }
      }else{
        if(bz){
          return 3;
        }else{
          return 4;
        }
      }
    }
  }


}

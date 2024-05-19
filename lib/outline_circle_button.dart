import 'package:flutter/material.dart';


typedef Callback = void Function();

class OutlineCircleButton extends StatelessWidget {


  final Callback callback;
  final radius;
  final borderSize;
  final borderColor;
  final foregroundColor;
  final child;


  OutlineCircleButton({
    Key? key,
    required this.callback,
    required this.borderSize,
    required this.radius,
    required this.borderColor,
    required this.foregroundColor,
    required this.child,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: borderSize),
          color: foregroundColor,
          shape: BoxShape.circle,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              child: child??SizedBox(),
              onTap: () async {
                  callback.call();
              }
          ),
        ),
      ),
    );
  }
}
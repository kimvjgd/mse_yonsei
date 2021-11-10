import 'package:flutter/material.dart';

class Background extends StatelessWidget {

  final String file_name;

  const Background({Key? key, required this.file_name}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 0,
      right: 0,
      left: 0,
      child: FittedBox(
          fit: BoxFit.fill,
          child: Image.asset('assets/images/${file_name}.png')),
    );
  }
}
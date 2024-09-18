import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonBackCustom extends StatefulWidget {
  final double padButton;

  ButtonBackCustom({required this.padButton});

  @override
  _ButtonBackCustomState createState() => _ButtonBackCustomState();
}

class _ButtonBackCustomState extends State<ButtonBackCustom> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: Padding(
        padding: EdgeInsets.all(widget.padButton),
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
              color: _isPressed ? Colors.blueGrey : Color(0xff434856),
              borderRadius: BorderRadius.circular(30)
          ),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white70,
            size: 30,
          ),
        ),
      ),
    );
  }
}
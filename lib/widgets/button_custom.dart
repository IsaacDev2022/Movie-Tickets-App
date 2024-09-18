import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String textButton;
  final VoidCallback onPressed;

  ButtonCustom({required this.textButton, required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 500,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.transparent,
        ),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.amber],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10)
          ),
          child: Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(
              minWidth: 88,
              minHeight: 36,
            ),
            child: Text(
              textButton,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      )
    );
  }
}
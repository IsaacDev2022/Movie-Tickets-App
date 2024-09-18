import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final String hint;
  final Icon icon;
  final bool obscure;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;

  TextFieldCustom({
    required this.hint,
    required this.icon,
    required this.obscure,
    required this.onChanged,
    this.validator,
    Key? key
  }) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return buildTextField3();
  }

  Widget buildTextField3() => TextFormField(
    obscureText: obscure,
    onChanged: onChanged,
    validator: validator,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(5.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(5.5),
      ),
      prefixIcon: icon,
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400]),
      filled: true,
      fillColor: Colors.grey[800]
    ),
    style: TextStyle(
      color: Colors.grey[400]
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyInput3 extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyInput3({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);
  @override


  State<MyInput3> createState() => _MyInput3State();
}

class _MyInput3State extends State<MyInput3> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText && !isPasswordVisible,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          fillColor: Colors.black,
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
            color: Colors.black,
            icon: Icon(isPasswordVisible ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
          ),
        ),
      ),
    );
  }
}

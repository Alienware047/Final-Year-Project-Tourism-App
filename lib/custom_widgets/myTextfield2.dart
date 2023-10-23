import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyInput2 extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyInput2({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  State<MyInput2> createState() => _MyInput2State();
}

class _MyInput2State extends State<MyInput2> {
  String? errorText;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        if (widget.hintText.toLowerCase() == 'email' &&
            !isValidEmail(widget.controller.text)) {
          errorText = 'Invalid email format';
        } else {
          errorText = null;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText,
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
          hintStyle: TextStyle(color: Colors.grey[500]),
          errorText: errorText,
        ),
      ),
    );
  }

  bool isValidEmail(String value) {
    // Add your email validation logic here
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(value);
  }
}

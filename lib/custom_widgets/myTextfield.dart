import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyInput extends StatelessWidget {


  final String hintText;
  final bool obscureText;

  final Function callback;
  bool obcureText;
  String input_data = "";

  MyInput({
  super.key,
    required this.obcureText,
    required this.callback,
    required this.hintText,
    required this.obscureText
});




  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))
      ),
      child: TextField(

        onChanged: (value){
          callback(input_data);
        },
        // controller: controller,
        obscureText: obscureText,
        // inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),],
        // decoration: InputDecoration(
        //   enabledBorder: const OutlineInputBorder(
        //     borderSide: BorderSide(
        //         color: Colors.black),
        //   ),
        //   focusedBorder: const OutlineInputBorder(
        //     borderSide: BorderSide(
        //         color: Colors.white),
        //   ),
        //   fillColor: Colors.black,
        //   filled: true,
        //   hintText:hintText,
        //   hintStyle: TextStyle(color: Colors.grey[500]),
        //
        // ),

      ),
    );
  }
}


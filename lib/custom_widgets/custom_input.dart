import 'package:flutter/Material.dart';

class CustomInput extends StatefulWidget {
  String hint_text ;
  final Function callback;
  bool obcureText;

  CustomInput({
    Key? key,
    required this.hint_text,
    required this.obcureText,
    required this.callback
  }) : super(key: key);

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {

  String input_data = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))
      ),
      child:  TextField(
        onChanged: (value){
          input_data = value;
          widget.callback(input_data);

        },
        obscureText: widget.obcureText,
        decoration:  InputDecoration(
            hintText: widget.hint_text,
            hintStyle: const TextStyle(
              color: Colors.grey,

            ),
            border: InputBorder.none
        ),

      ),
    );
  }
}

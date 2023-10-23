import 'package:flutter/material.dart';
import 'dart:async';

class Button_1 extends StatefulWidget {
  final Function()? onTap;


  const Button_1({super.key, required this.onTap});

  @override
  _Button_1State createState() => _Button_1State();
}

class _Button_1State extends State<Button_1> {
  bool _isLoading = false;

  void _handleTap() async {
    setState(() {
      _isLoading = true;
    });

    if (widget.onTap != null) {
      await widget.onTap!();
    }

    Timer(Duration(seconds: 7), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isLoading ? null : _handleTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            else
              Text(
                'Login',
                style: TextStyle(color: Colors.white,
                fontSize: 20),

              ),
            if (_isLoading) SizedBox(height: 15),
            if (_isLoading)
              Text(
                'Logging in...',
                style: TextStyle(color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}

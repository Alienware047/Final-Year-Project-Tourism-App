import 'package:flutter/material.dart';
import 'dart:async';

class Button_4 extends StatefulWidget {
  final Function()? onTap;


  const Button_4({super.key, required this.onTap});

  @override
  _Button_4State createState() => _Button_4State();
}

class _Button_4State extends State<Button_4> {
  bool _isLoading = false;

  void _handleTap() async {
    setState(() {
      _isLoading = true;
    });

    if (widget.onTap != null) {
      await widget.onTap!();
    }

    Timer(const Duration(seconds: 7), () {
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
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            else
              const Text(
                'Change Password',
                style: TextStyle(color: Colors.white,
                    fontSize: 20),

              ),
            if (_isLoading) const SizedBox(height: 15),
            if (_isLoading) const Text(
              'Changing Password.......',
              style: TextStyle(color: Colors.white,fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

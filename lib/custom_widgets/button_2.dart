import 'package:flutter/material.dart';

class Button_2 extends StatelessWidget {
  final Function()? onTap;

  const Button_2({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: GestureDetector(
        onTap: onTap,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Register',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(width: 8.0),
              Container(
                width: 24.0,
                height: 24.0,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.forward_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Color buttonColor;
  final VoidCallback onPressed;

  const MyButton(
      {Key? key,
      required this.title,
      required this.buttonColor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // <-- Radius
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 12),
        textAlign: TextAlign.center,
      ),
    );
  }
}

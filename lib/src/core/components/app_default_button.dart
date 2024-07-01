import 'package:flutter/material.dart';

class AppDefaultButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final double widthFactor;
  final double height;
  final VoidCallback onPressed;

  const AppDefaultButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
    this.widthFactor = 0.9,
    this.height = 55,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widthFactor,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}

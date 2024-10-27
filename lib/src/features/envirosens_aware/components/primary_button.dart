import 'package:flutter/material.dart';

import 'package:sencees/src/features/envirosens_aware/constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.title,
    required this.process,
    super.key,
    this.screenWidth,
    required this.color,
  });

  final double? screenWidth;
  final String? title;
  final Color color;
  final void Function()? process;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth,
      child: ElevatedButton(
        onPressed: process,
        style: ElevatedButton.styleFrom(
          elevation: 6.0,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        child: Text(
          title!,
          style: kMainButtonTextStyle,
        ),
      ),
    );
  }
}

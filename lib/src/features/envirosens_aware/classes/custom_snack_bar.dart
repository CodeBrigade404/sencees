import 'package:flutter/material.dart';
import 'package:sencees/src/features/envirosens_aware/constants.dart';

class CustomSnackBar extends SnackBar {
  final String title;
  final Color backColor;
  final int time;
  final IconData? icon;

  CustomSnackBar({
    required this.backColor,
    required this.time,
    required this.title,
    this.icon,
    super.key,
  }) : super(
          content: Row(
            children: <Widget>[
              Icon(
                icon,
                color: kBrilliantWhite,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(title),
            ],
          ),
          backgroundColor: backColor,
          behavior: SnackBarBehavior.fixed,
          duration: Duration(seconds: time),
        );
}

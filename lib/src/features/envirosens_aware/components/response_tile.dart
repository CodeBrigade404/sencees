import 'package:flutter/material.dart';
import 'package:sencees/src/features/envirosens_aware/constants.dart';

class ResponseTile extends StatelessWidget {
  final String title;
  final String accuracy;
  final String iconName;
  final String hexColor;
  const ResponseTile(
      {super.key,
      required this.title,
      required this.iconName,
      required this.hexColor,
      required this.accuracy});

// Helper function for defining color
  Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', ''); // Remove '#' if present
    if (hex.length == 6) {
      hex = 'FF$hex'; // Add 'FF' for full opacity
    }
    return Color(int.parse(hex, radix: 16));
  }

// Helper function for defining icon
  IconData _getIconData(String iconName) {
    switch (iconName) {
      case "flutter_dash":
        return Icons.flutter_dash;
      case "pets":
        return Icons.pets;
      case "cruelty_free":
        return Icons.cruelty_free;
      case "construction":
        return Icons.construction;
      case "directions_car":
        return Icons.directions_car;
      case "airport_shuttle":
        return Icons.airport_shuttle;
      case "local_shipping":
        return Icons.local_shipping;
      case "pedal_bike":
        return Icons.pedal_bike;
      case "train":
        return Icons.train;
      case "flight":
        return Icons.flight;
      case "alarm_on":
        return Icons.alarm_on;
      case "notifications_active":
        return Icons.notifications_active;
      case "phone_in_talk":
        return Icons.phone_in_talk;
      case "woman":
        return Icons.woman;
      case "man":
        return Icons.man;
      case "family_restroom":
        return Icons.family_restroom;
      case "thunderstorm":
        return Icons.thunderstorm;
      case "radio":
        return Icons.radio;
      case "desktop_windows":
        return Icons.desktop_windows;
      case "meeting_room":
        return Icons.meeting_room;
      case "campaign":
        return Icons.campaign;
      case "music_note":
        return Icons.music_note;
      default:
        return Icons.help_outline; // Default icon if no match is found
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: kBrilliantWhite,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.2), // Shadow color with transparency
            spreadRadius: 1, // How far the shadow spreads
            blurRadius: 4, // How soft the shadow is
            offset: const Offset(0, 4), // Offset in x and y direction
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _hexToColor(hexColor),
              boxShadow: [
                BoxShadow(
                  color: _hexToColor(hexColor)
                      .withOpacity(0.3), // Shadow color with transparency
                  spreadRadius: 1, // How far the shadow spreads
                  blurRadius: 4, // How soft the shadow is
                  offset: const Offset(2, 6), // Offset in x and y direction
                ),
              ]),
          child: Icon(
            _getIconData(iconName),
            color: kBrilliantWhite,
          ),
        ),
        title: Text(
          title,
          style: kSubTitleTextStyle,
        ),
        trailing: Text(
          accuracy,
          style: kSubTitleTextStyle.copyWith(
            color: _hexToColor(hexColor),
          ),
        ),
      ),
    );
  }
}

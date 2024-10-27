import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:sencees/src/core/components/app_default_button.dart';
import 'package:sencees/src/core/constants/app_colors.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class WarnAlertAwareView extends StatelessWidget {
  const WarnAlertAwareView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WarnAlert Aware')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Glowing avatar with smaller image size
          AvatarGlow(
            startDelay: const Duration(milliseconds: 100),
            glowColor: AppColors.appRed,
            glowShape: BoxShape.circle,
            animate: true,
            curve: Curves.fastOutSlowIn,
            child: Container(
              width: 150.0,
              height: 150.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/warn.png'),
                  fit: BoxFit.cover, // Ensures the image is fully visible inside the circle
                ),
              ),
            ),
          ),

          // Text showing emergency warning message
          const SizedBox(height: 80), // Adjusted spacing
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'Warning! Immediate attention is required!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Button for emergency action
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: AppDefaultButton(
              text: 'Emergency',
              backgroundColor: const Color(0xFFF70000),
              icon: Icons.emergency_rounded, // Emergency icon
              onPressed: () {
                // Handle emergency button press
              },
            ),
          )
        ],
      ),
    );
  }
}

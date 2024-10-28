import 'package:flutter/material.dart';

class Suggestions extends StatelessWidget {
  final List<String> aiSuggestions;
  final Function(String) onSuggestionTap;

  const Suggestions({
    super.key,
    required this.aiSuggestions,
    required this.onSuggestionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0,
        children: aiSuggestions.map(
          (suggestion) {
            return TextButton(
              onPressed: () => onSuggestionTap(suggestion),
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 239, 238, 238),
              ),
              child: Text(suggestion),
            );
          },
        ).toList(),
      ),
    );
  }
}

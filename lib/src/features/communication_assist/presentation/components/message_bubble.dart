import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

class MessageBubble extends StatefulWidget {
  final String message;
  final bool isUserMessage;
  final bool isMaleVoice;
  final VoidCallback onStartListening;
  final VoidCallback onStopListening;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isUserMessage,
    required this.isMaleVoice,
    required this.onStartListening,
    required this.onStopListening,
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayMessage(String message) async {
    final voice = widget.isMaleVoice ? 'alloy' : 'nova';

    try {
      // Stop speech recognition when audio starts playing
      if (!widget.isUserMessage) {
        widget.onStopListening();
      }

      if (_isPlaying) {
        await _audioPlayer.stop();
        setState(() {
          _isPlaying = false;
        });
      } else {
        setState(() {
          _isPlaying = true;
        });

        // Listen for audio completion to restart speech recognition
        _audioPlayer.onPlayerComplete.listen((event) {
          setState(() {
            _isPlaying = false;
          });

          // Restart speech recognition after audio finishes playing
          if (!widget.isUserMessage) {
            widget.onStartListening();
          }
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error generating or playing audio: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.isUserMessage ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        ChatBubble(
          alignment: !widget.isUserMessage ? Alignment.topRight : null,
          clipper: ChatBubbleClipper1(
            type: widget.isUserMessage ? BubbleType.receiverBubble : BubbleType.sendBubble,
          ),
          backGroundColor: widget.isUserMessage ? Colors.white : Colors.lightBlueAccent,
          margin: const EdgeInsets.only(top: 20),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Text(
              widget.message,
              style: TextStyle(
                color: widget.isUserMessage ? Colors.black : Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        if (!widget.isUserMessage)
          IconButton(
            icon: Icon(_isPlaying ? Icons.stop : Icons.volume_up),
            onPressed: () => _togglePlayMessage(widget.message),
          ),
      ],
    );
  }
}

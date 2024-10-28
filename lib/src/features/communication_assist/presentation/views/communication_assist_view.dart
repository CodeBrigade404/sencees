import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sencees/src/core/utils/Utils.dart';
import 'package:sencees/src/features/communication_assist/controllers/chat_controller.dart';
import 'package:sencees/src/features/communication_assist/presentation/components/loading_indicator.dart';
import 'package:sencees/src/features/communication_assist/presentation/components/message_bubble.dart';
import 'package:sencees/src/features/communication_assist/presentation/components/message_input.dart';
import 'package:sencees/src/features/communication_assist/presentation/components/suggestions.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class CommunicationAssistView extends ConsumerStatefulWidget {
  const CommunicationAssistView({super.key});

  @override
  ConsumerState<CommunicationAssistView> createState() => _CommunicationAssistView();
}

class _CommunicationAssistView extends ConsumerState<CommunicationAssistView> {
  final SpeechToText _speechToText = SpeechToText();
  final TextEditingController _controller = TextEditingController();

  List<Map<String, String>> messages = [];
  List<String> aiSuggestions = [];
  bool _speechEnabled = false;
  bool _speechAvailable = false;
  bool _isLoading = false;
  String _currentWords = '';
  late String uuid;

  @override
  void initState() {
    super.initState();
    _initStt();
    uuid = Utils.generateUUID();
  }

  void _initStt() async {
    _speechAvailable = await _speechToText.initialize(
      onError: (SpeechRecognitionError error) async {},
      onStatus: (String status) async {
        if (status == "done" && _speechEnabled) {
          _sendUserMessage(_currentWords);
          setState(() {
            _currentWords = "";
            _speechEnabled = false;
          });

          await Future.delayed(const Duration(milliseconds: 50));
          await _startListening();
        }
      },
    );
  }

  Future _startListening() async {
    if (!_speechAvailable) {
      debugPrint("Speech recognition is not available.");
      return;
    }
    await _stopListening();
    await Future.delayed(const Duration(milliseconds: 50));
    try {
      await _speechToText.listen(
        onResult: _onSpeechResult,
        listenFor: const Duration(days: 1),
      );
      setState(() {
        _speechEnabled = true;
      });
    } catch (e) {
      debugPrint("Error starting speech recognition: $e");
    }
  }

  Future _stopListening() async {
    setState(() {
      _speechEnabled = false;
    });
    await _speechToText.stop();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _currentWords = result.recognizedWords;
    });
  }

  void _sendUserMessage(String message) async {
    if (message.trim().isEmpty) return;
    setState(() {
      messages.add({'role': 'user', 'message': message});
      _isLoading = true;
      aiSuggestions = [];
    });

    final chatController = ref.read(chatControllerProvider);
    final response = await chatController.sendMessage(uuid, message);

    setState(() {
      _isLoading = false;
      aiSuggestions = response?.answer ?? [];
    });
  }

  void _sendAiMessage(String message) {
    if (message.trim().isEmpty) return;
    setState(() {
      messages.add({'role': 'ai', 'message': message});
      aiSuggestions = [];
    });
    _controller.clear();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Communication Assist'),
        actions: [
          IconButton(
            icon: Icon(
              _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
            ),
            onPressed: _speechToText.isNotListening ? _startListening : _stopListening,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= messages.length) {
                  return const LoadingIndicator();
                }
                final message = messages[index];
                final isUserMessage = message['role'] == 'user';
                return MessageBubble(
                  message: message['message'] ?? '',
                  isUserMessage: isUserMessage,
                  isMaleVoice: false,
                  onStartListening: _startListening,
                  onStopListening: _stopListening,
                );
              },
            ),
          ),
          if (aiSuggestions.isNotEmpty)
            Suggestions(
              aiSuggestions: aiSuggestions,
              onSuggestionTap: _sendAiMessage,
            ),
          MessageInput(
            controller: _controller,
            onSend: () => _sendAiMessage(_controller.text),
          ),
        ],
      ),
    );
  }
}

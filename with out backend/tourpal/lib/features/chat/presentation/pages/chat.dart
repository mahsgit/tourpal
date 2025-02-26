import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tourpal/features/chat/presentation/pages/message.dart';
import 'package:tourpal/features/chat/presentation/pages/testchat.dart';
import 'dart:convert';

// import '../widgets/message.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _textController = TextEditingController();
  final List<Message> _messages = [];

  Future<void> _sendMessage(String message) async {
    final url =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyCJJDJnHk6kPtYs1pT6WKqLF37AS0nM9LE';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'contents': [
        {
          'parts': [
            {'text': message}
          ]
        }
      ]
    });

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody != null && responseBody['candidates'] != null) {
          final candidates = responseBody['candidates'];

          if (candidates.isNotEmpty && candidates[0]['content'] != null) {
            final content = candidates[0]['content'];

            if (content['parts'] != null && content['parts'].isNotEmpty) {
              final botMessage = content['parts'][0]['text'];

              // Update the UI
              setState(() {
                _messages.add(
                    Message(text: message, isFromUser: true)); // User's message
                _messages.add(Message(
                    text: botMessage, isFromUser: false)); // AI response
              });
            } else {
              print('Error: No text found in parts.');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Error: No text found in response.'),
              ));
            }
          } else {
            print('Error: Content is empty or null.');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Error: Invalid response structure.'),
            ));
          }
        } else {
          print('Error: Candidates are empty or null.');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: Invalid response structure.'),
          ));
        }
      } else {
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Error: ${response.statusCode} - ${response.reasonPhrase}'),
        ));
      }
    } catch (e) {
      print('Exception caught: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Exception: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with Gemini AI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Message(
                      text: message.text,
                      isFromUser: message.isFromUser,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      final message = _textController.text.trim();
                      if (message.isNotEmpty) {
                        _sendMessage(message);
                        _textController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

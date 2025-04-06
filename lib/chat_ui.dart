import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'dart:convert';

class AIFitnessChatPage extends StatefulWidget {
  @override
  _AIFitnessChatPageState createState() => _AIFitnessChatPageState();
}

class _AIFitnessChatPageState extends State<AIFitnessChatPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages =
      []; // {'role': 'user' or 'ai', 'text': '...'}

  Future<void> sendMessage(String prompt) async {
    setState(() {
      messages.add({'role': 'user', 'text': prompt});
    });

    final url = Uri.parse('https://ai-chatbot-8yni.onrender.com/chat');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'prompt': prompt}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          messages.add({'role': 'ai', 'text': data['response']});
        });
      } else {
        setState(() {
          messages.add({'role': 'ai', 'text': 'Error: ${response.body}'});
        });
      }
    } catch (e) {
      setState(() {
        messages.add({'role': 'ai', 'text': 'Failed to connect to server.'});
      });
    }
  }

  Widget buildMessage(Map<String, String> msg) {
    bool isUser = msg['role'] == 'user';
    return Container(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: isUser ? Colors.deepPurple : Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child:
          isUser
              ? Text(msg['text']!, style: TextStyle(color: Colors.white))
              : MarkdownBody(
                data: msg['text']!,
                styleSheet: MarkdownStyleSheet.fromTheme(
                  Theme.of(context),
                ).copyWith(
                  p: TextStyle(color: Colors.white),
                  strong: TextStyle(color: Colors.yellow),
                ),
              ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Fitness Coach', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              reverse: true,
              children: messages.reversed.map(buildMessage).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Ask your coach...',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (text) {
                      if (text.trim().isNotEmpty) {
                        sendMessage(text.trim());
                        _controller.clear();
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.white),
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      sendMessage(text);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

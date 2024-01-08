import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


class MyChatbotPage extends StatefulWidget {
  @override
  _MyChatbotScreenState createState() => _MyChatbotScreenState();
}

class _MyChatbotScreenState extends State<MyChatbotPage> {
  
  String userQuestion = '';
  String chatbotResponse = '';

  Future<void> getChatbotResponse(String prompt) async {
    String functionUrl = dotenv.get('FUNCTION_URL');
    final response = await http.post(
      Uri.parse(functionUrl),
      body: prompt,
      headers: {'Content-Type': 'plain/text'},
    );

    setState(() {
      chatbotResponse = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Chatbot App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  userQuestion = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter your question...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                getChatbotResponse(userQuestion);
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 16),
            Text(
              'Chatbot Response:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              chatbotResponse,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
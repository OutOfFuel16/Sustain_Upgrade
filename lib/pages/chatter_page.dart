import 'dart:ui';

import 'package:campus_carbon/keys/urls.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatterPage extends StatefulWidget {
  const ChatterPage({super.key});

  @override
  State<ChatterPage> createState() => _ChatterPageState();
}

class _ChatterPageState extends State<ChatterPage> {
  final model =
      GenerativeModel(model: 'gemini-pro', apiKey: UrlConstants.geminiApi);
  final ChatUser _currentUser = ChatUser(id: '1');
  final ChatUser _chatAI = ChatUser(id: '2', firstName: "EcoAI");
  late final chat;
  final List<ChatMessage> _messages = <ChatMessage>[];

  startChat() async {
    //final chat = model.startChat(history: UrlConstants.prompt);
    setState(() {
      chat = model.startChat(history: UrlConstants.prompt);
      _messages.add(ChatMessage(
          user: _chatAI,
          createdAt: DateTime.now(),
          text: 'Hi, I am EcoAI. How can I help you?'));
    });
  }

  Future<void> getChatResponse(ChatMessage msg, dynamic chat) async {
    setState(() {
      _messages.insert(0, msg);
    });
    final content = Content.text(msg.text);
    final response = await chat.sendMessage(content);

    setState(() {
      _messages.insert(
          0,
          ChatMessage(
              user: _chatAI,
              createdAt: DateTime.now(),
              text: response.text ?? ""));
    });
  }

  @override
  void initState() {
    super.initState();
    startChat();
  }

  @override
  void dispose() {
    super.dispose();
    chat.endchat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          "EcoAI",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.grey[100]),
        ),
        backgroundColor: Colors.teal[800],
        iconTheme: IconThemeData(color: Colors.grey[100]),
      ),
      body: DashChat(
          currentUser: _currentUser,
          onSend: (ChatMessage msg) {
            getChatResponse(msg, chat);
          },
          messages: _messages,


          messageOptions: MessageOptions(
            currentUserContainerColor: Colors.black,
            currentUserTextColor: Colors.grey[300],


            containerColor: Colors.teal[800]!,
            textColor: Colors.grey[300]!,

          ),

        inputOptions: InputOptions(
          inputDecoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: "Write a message.. ",
              hintStyle: TextStyle(color: Colors.grey[500])),
          )

        ),


      );
  }
}

import 'package:google_generative_ai/google_generative_ai.dart';

class UrlConstants {
  static const String apiUrl = 'http://192.168.0.109:3000';
  static const String geminiApi = 'AIzaSyBmTMHhwVJD3WRzdk5rZHcHXpfsGrBsRo4';

  static List<Content> prompt = [
    Content.text('Hi, gemini. I am creating a chat bot using your api call in my app and need your help to be the required chatbot. The app is called EcoTrack and your name will be EcoAI. Through this app users can calculate, track and offset their carbon emissions. They can also see the continuously monitored carbon footprint of IIT Mandi North Campus. Your main task is to provide recommendations. If your able to be this chatbot, please reply "Hi, I am EcoAI. How can I help you?" and nothing else.'),

    Content.model([TextPart('Hi, I am EcoAI. How can I help you?')])
  ];
}
//urls

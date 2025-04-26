import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebLinkPage extends StatefulWidget {
  const WebLinkPage({super.key});

  @override
  _WebLinkPageState createState() => _WebLinkPageState();
}

class _WebLinkPageState extends State<WebLinkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check your real-time consumption value'),
      ),
      body: const WebView(
        initialUrl: 'http://192.168.4.1/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}

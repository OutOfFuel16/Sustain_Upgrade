import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TradingPageWren extends StatefulWidget {
  const TradingPageWren({super.key});



  @override
  State<TradingPageWren> createState() => _TradingPageWrenState();
}

class _TradingPageWrenState extends State<TradingPageWren> {
  late final WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(title: const Text('Trading'),),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: "https://www.wren.co/offset-anything",
          onPageStarted: (url){
            Future.delayed(const Duration(milliseconds: 300));
            //_controller.runJavascript("document.querySelector('.css-132dfuh').style.display = 'none'");
          },
          onWebViewCreated: (controller){
            _controller = controller;
          },
        ),
      ),
    );
  }
}


class TradingPageProjects extends StatefulWidget {
  const TradingPageProjects({super.key});

  @override
  State<TradingPageProjects> createState() => _TradingPageProjectsState();
}

class _TradingPageProjectsState extends State<TradingPageProjects> {
  late final WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(title: const Text('Trading'),),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: "https://terrapass.com/product-category/individuals",
          onPageStarted: (url){
            Future.delayed(const Duration(milliseconds: 300));
            //_controller.runJavascript("document.querySelector('.css-132dfuh').style.display = 'none'");
          },
          onWebViewCreated: (controller){
            _controller = controller;
          },
        ),
      ),
    );
  }
}


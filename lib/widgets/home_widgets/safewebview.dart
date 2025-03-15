// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class SafeWebView extends StatefulWidget {
//   final String url;
//   const SafeWebView({Key? key, required this.url}) : super(key: key);

//   @override
//   State<SafeWebView> createState() => _SafeWebViewState();
// }

// class _SafeWebViewState extends State<SafeWebView> {
//   late final WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();

//     _controller =
//         WebViewController()
//           ..setJavaScriptMode(JavaScriptMode.unrestricted)
//           ..loadRequest(Uri.parse(widget.url));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("WebView")),
//       body: WebViewWidget(controller: _controller),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SafeWebView extends StatefulWidget {
  final String url;
  const SafeWebView({Key? key, required this.url}) : super(key: key);

  @override
  State<SafeWebView> createState() => _SafeWebViewState();
}

class _SafeWebViewState extends State<SafeWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("WebView")),
      body: WebViewWidget(controller: _controller),
    );
  }
}

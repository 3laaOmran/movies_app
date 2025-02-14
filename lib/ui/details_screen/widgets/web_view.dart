import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebViewScreen extends StatelessWidget {
  final String newsUrl;
  const WebViewScreen({super.key, required this.newsUrl});
  @override Widget build(BuildContext context) {
    WebViewController controller =
     WebViewController()
       ..setJavaScriptMode(JavaScriptMode.unrestricted)
       ..setNavigationDelegate( NavigationDelegate(
         onNavigationRequest: (NavigationRequest request) {
           if (request.url.startsWith('https://www.youtube.com/')) {
             return NavigationDecision.prevent; }
           return NavigationDecision.navigate; }, ), )
       ..loadRequest(Uri.parse(newsUrl));
    return SafeArea( child: Scaffold( body: WebViewWidget(controller: controller),
    ),
    );
  }
}
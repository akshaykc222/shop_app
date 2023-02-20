import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewCommon extends StatefulWidget {
  final String url;

  const WebViewCommon({Key? key, required this.url}) : super(key: key);

  @override
  State<WebViewCommon> createState() => _WebViewCommonState();
}

class _WebViewCommonState extends State<WebViewCommon> {
  late WebViewController controller;
  ValueNotifier<int> progressVal = ValueNotifier(0);
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.p
            progressVal.value = progress;
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
          SizedBox(
            width: 20,
            height: 20,
            child: ValueListenableBuilder<int>(
                valueListenable: progressVal,
                builder: (context, data, j) {
                  return CircularProgressIndicator(
                    value: progressVal.value.toDouble(),
                  );
                }),
          )
        ],
      )),
    );
  }
}

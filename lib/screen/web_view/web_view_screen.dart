import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class WebViewScreen extends StatefulWidget {
  final String? link;
  const WebViewScreen({this.link});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  InAppWebViewController? inAppWebViewController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void checkDirect() async {
    if (inAppWebViewController != null) {
      if (await inAppWebViewController!.canGoBack() == true) {
        canBack = true;
      } else {
        canBack = false;
      }

      if (await inAppWebViewController!.canGoForward() == true) {
        canNext = true;
      } else {
        canNext = false;
      }
      setState(() {});
    }
  }

  var canBack = false;
  var canNext = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height,
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    iconSize: 20,
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: canBack ? Colors.black : Colors.grey,
                    ),
                    onPressed: canBack
                        ? () {
                            if (inAppWebViewController != null) {
                              inAppWebViewController!.goBack();
                            }
                          }
                        : null),
                IconButton(
                    iconSize: 20,
                    icon: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: canNext ? Colors.black : Colors.grey,
                    ),
                    onPressed: canNext
                        ? () {
                            if (inAppWebViewController != null) {
                              inAppWebViewController!.goForward();
                            }
                          }
                        : null),
                IconButton(
                    iconSize: 20,
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      if (inAppWebViewController != null) {
                        inAppWebViewController!.reload();
                        inAppWebViewController!.scrollTo(x: 0, y: 0);
                      }
                    }),
                IconButton(
                    iconSize: 20,
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Get.back();
                    }),
              ],
            ),
          ),
          Expanded(
            child: InAppWebView(
              onLoadStart: (controller, url) {
                inAppWebViewController = controller;
                checkDirect();
              },
              onLoadStop: (controller, url) {
                checkDirect();
              },

              initialUrlRequest: URLRequest(
                url: Uri.parse(widget.link!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

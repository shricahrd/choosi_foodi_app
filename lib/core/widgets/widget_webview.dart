import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/app_images_utils.dart';

class WidgetWebview extends StatefulWidget {
  String url;
  String appbarName;

  WidgetWebview({Key? key, required this.url, required this.appbarName}) : super(key: key);

  @override
  State<WidgetWebview> createState() => _WidgetWebviewState();
}

class _WidgetWebviewState extends State<WidgetWebview>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = true;
  final _key = UniqueKey();
  double webProgress = 0;
  dynamic finalUrl;

  // WebViewController? controller;
  late final WebViewController controller;

  @override
  void initState() {
    isLoading = true;
    finalUrl = widget.url;
    debugPrint('finalUrl: $finalUrl');
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            debugPrint("onProgress-->$progress");
            if (mounted) {
              setState(() {
                isLoading = true;
                debugPrint("isLoading-->$isLoading");
              });
            }
          },
          onPageStarted: (String url) {
            debugPrint("onPageStart-->${url}");
          },
          onPageFinished: (String url) {
            debugPrint("onPageFinished-->${url}");
            if (mounted) {
              setState(() {
                isLoading = false;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint("onWebResourceError-->${error.description}");
          },
        ),
      )
      ..enableZoom(true)
      ..clearCache()
      ..loadRequest(Uri.parse(Uri.encodeFull('https://docs.google.com/gview?embedded=true&url=$finalUrl')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.transparent, //change your color here
        ),
        toolbarHeight: 60,
        shadowColor: Color(HINTCOLOR),
        backgroundColor: Color(WHITE),
        flexibleSpace: Container(
          height: double.infinity,
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: Image.asset(
                  ic_right_side_arrow,
                  width: 25,
                  color: Color(ORANGE),
                  height: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              WidgetText.widgetPoppinsRegularText(
                widget.appbarName,
                Color(BLACK),
                16,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                controller.reload();
              },
              icon: Icon(Icons.refresh, color: Color(ORANGE),))
        ],
      ),
      body: Container(
        color: Colors.white,
        child: finalUrl.split(".").last == "png" ||
                finalUrl.split(".").last == "jpg"||
                finalUrl.split(".").last == "jpeg"
            ? Center(child: Image.network(finalUrl))
            : Stack(
                children: <Widget>[
                  WebViewWidget(
                    controller: controller,
                    key: _key,
                  ),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Color(ORANGE),
                          ),
                        )
                      : Stack(),
                ],
              ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

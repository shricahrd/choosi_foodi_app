import 'dart:convert';
import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NotificationDetailsScreen extends StatefulWidget {
  dynamic body, title;

  NotificationDetailsScreen({required this.title, required this.body});

  @override
  _NotificationDetailsScreenState createState() => _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> with AutomaticKeepAliveClientMixin  {
  dynamic finalUrl;
  bool isLoading=true;
  final _key = UniqueKey();
  RegExp exp = RegExp(r"<[^>]*>",multiLine: true,caseSensitive: true);
  late final WebViewController controller;
  // @override
  // void initState() {
  //   finalUrl = widget.body;
  //   super.initState();
  // }


  @override
  void initState() {
    isLoading = true;
    print('Url: ${widget.body}');
    if(exp.hasMatch(widget.body.toString())){
      loadLocalHtml();
    }else{
      print('Not html');
      finalUrl = widget.body;
      print('LoadUrl : $finalUrl');
    }
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            debugPrint("onProgress-->$progress");
            if(mounted) {
              setState(() {
                isLoading = true;
                // webprogress = progress;
                // debugPrint("webprogress-->$webprogress");
                debugPrint("isLoading-->$isLoading");
              });
            }
          },
          onPageStarted: (String url) {
            debugPrint("onPageStart-->${url}");
          },
          onPageFinished: (String url) {
            debugPrint("onPageFinished-->${url}");
            if(mounted){
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

  void loadLocalHtml(){
    final url = Uri.dataFromString(widget.body,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')).toString();
    finalUrl = url;
    print('LoadUrl : $finalUrl');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(widget.title.toString()),backgroundColor: Color(ORANGE),
        actions: [
          IconButton(onPressed: (){
            controller.reload();
          }, icon: Icon(Icons.refresh))
        ],
      ),
      body: Container(
        color:  Colors.white,
        child:
        Stack(
          children: <Widget>[
            WebViewWidget(
              controller: controller,
              key: _key,
            ),
            isLoading ? Center(child: CircularProgressIndicator(color: Color(ORANGE),),)
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


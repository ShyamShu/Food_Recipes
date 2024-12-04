import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class Recipe_View extends StatefulWidget {

  String url = "";
  Recipe_View(this.url);
  @override
  State<Recipe_View> createState() => _Recipe_ViewState();
}

class _Recipe_ViewState extends State<Recipe_View> {
  String finalUrl = "";
  WebViewController controller = WebViewController();
  @override
  void initState() {
    // TODO: implement initState
    if(widget.url.toString().contains("http://"))
      {
        finalUrl = widget.url.toString().replaceAll("http://", "https://");
      }
    else{
      finalUrl = widget.url;
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe is Here"),
      ),
      body: Container(
        child: WebViewWidget(
          controller: controller
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..loadRequest(Uri.parse(finalUrl)),
        ),
      ),
    );
  }


}


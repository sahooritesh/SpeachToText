import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Webb extends StatefulWidget {
  final String text;
  const Webb(this.text);

  // const Webb({ Key key,@required this.text }) : super(key: key);

  @override
  _WebbState createState() => _WebbState();
}

class _WebbState extends State<Webb> {
  

  @override
  Widget build(BuildContext context) {

    String new_text=widget.text.replaceAll(" ", "+");

    return WebviewScaffold(
      url: "https://www.google.com/search?q=${new_text}&rlz=1C1ONGR_enIN944IN944&oq=${new_text}&aqs=chrome..69i57j69i60l3.8453j0j7&sourceid=chrome&ie=UTF-8",
      withZoom: true,
      
    );
  }
}
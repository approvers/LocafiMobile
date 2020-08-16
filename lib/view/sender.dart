import 'package:flutter/material.dart';
import 'package:flutter_app/controller/sender.dart';

class SenderPage extends StatefulWidget {
  final ISenderController controller;

  const SenderPage({Key key, this.controller}) : super(key: key);

  @override
  _SenderPageState createState() => _SenderPageState();
}

class _SenderPageState extends State<SenderPage> {
  ISenderController controller;

  _SenderPageState({this.controller});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("ファイル送信"),
      ),
      body: Center(
        // TODO: Create detail component.
        child: Container(),
      ),
    );
  }
}

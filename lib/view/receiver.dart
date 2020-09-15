import 'package:flutter/cupertino.dart';
import 'package:locafi_mobile/controller/receiver.dart';

class ReceiverPage extends StatefulWidget {
  final IReceiverController controller;
  ReceiverPage({@required this.controller});

  @override
  State<ReceiverPage> createState() => _PageState();
}

class _PageState extends State<ReceiverPage> {
  @override
  Widget build(BuildContext context) {
    final serverName = ModalRoute.of(context).settings.arguments.toString();
    return Scaffold();
  }
}
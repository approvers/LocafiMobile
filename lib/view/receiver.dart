import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locafi_mobile/controller/receiver.dart';

class ReceiverPage extends StatefulWidget {
  final IReceiverController controller;
  ReceiverPage({@required this.controller});

  @override
  State<ReceiverPage> createState() => _PageState();
}

class _PageState extends State<ReceiverPage> {
  final List<int> selectedFiles = [];
  @override
  Widget build(BuildContext context) {
    final serverName = ModalRoute.of(context).settings.arguments.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("ファイル受け取り"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: saveSelectedFiles,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: deleteSelectedFiles,
          ),
        ],
      ),
      body: FutureBuilder(
        future: widget.controller.startServer(serverName),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            // TODO: Create Receiver Contents
            return Container();
          }
          if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  void saveSelectedFiles() {
    selectedFiles.sort();
    selectedFiles.reversed.forEach((index) {
      widget.controller.saveFile(index);
    });
  }
  void deleteSelectedFiles() {
    selectedFiles.sort();
    selectedFiles.reversed.forEach((index) {
      widget.controller.deleteFile(index);
    });
  }
}
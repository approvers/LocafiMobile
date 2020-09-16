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
  bool serverStarted = false;

  @override
  Widget build(BuildContext context) {
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
        future: startServer(context),
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

  Future<bool> startServer(BuildContext context) async {
    if (!serverStarted) {
      final serverName = ModalRoute.of(context).settings.arguments.toString();
      return await widget.controller.startServer(serverName);
    }
    serverStarted = true;

    return true;
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

class ReceiverFrame extends StatefulWidget {
  final IReceiverController controller;
  ReceiverFrame({@required this.controller});

  @override
  State<StatefulWidget> createState() => _ReceiverFrameState();
}

class _ReceiverFrameState extends State<ReceiverFrame> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
      ],
    );
  }
}

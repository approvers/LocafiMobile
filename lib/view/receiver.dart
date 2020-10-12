import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locafi_mobile/controller/receiver.dart';
import 'package:locafi_mobile/types/file.dart';

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
  Widget build(BuildContext context) => Scaffold(
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
          return ReceiverFrame(
            controller: widget.controller,
            selectFile: updateSelectFile,
            deselectFile: updateDeselectFile,
            selectedStates: selectedFiles,
          );
        }
        if (snapshot.hasError) {
          return Text(snapshot.error);
        }
        return CircularProgressIndicator();
      },
    ),
  );

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

  void updateDeselectFile(int index) {
    setState(() {
      selectedFiles.remove(index);
    });
  }

  void updateSelectFile(int index) {
    setState(() {
      selectedFiles.add(index);
    });
  }
}

class ReceiverFrame extends StatefulWidget {
  final IReceiverController<AbstractFile> controller;
  final void Function(int) selectFile;
  final void Function(int) deselectFile;
  final List<int> selectedStates;

  ReceiverFrame({
    @required this.controller,
    @required this.selectFile,
    @required this.deselectFile,
    @required this.selectedStates,
  });

  @override
  State<StatefulWidget> createState() => _ReceiverFrameState();
}

class _ReceiverFrameState extends State<ReceiverFrame> {
  List<AbstractFile> receivedFiles = [];

  void checkBoxHandler(bool state, int index) {
    if (state) {
      widget.selectFile(index);
      return;
    }
    widget.deselectFile(index);
  }

  Widget receivedFileCard(AbstractFile file, int index) => Card(
    child: Row(
      children: [
        Checkbox(
          onChanged: (bool value) => checkBoxHandler(value, index),
          value: widget.selectedStates.indexOf(index) != -1,
        ),
        Text(file.getFileName()),
        Text("size: ${file.getFileSize()}"),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    widget.controller.waitFiles().then((files) {
      setState(() {
        files.forEach((file) {
          receivedFiles.add(file);
        });
      });
    });

    return ListView.builder(
        itemCount: receivedFiles.length,
        itemBuilder: (BuildContext context, int index) =>
            receivedFileCard(receivedFiles[index], index)
    );
  }

  @override
  void initState() {
    super.initState();
    receivedFiles = widget.controller.getFileList();
  }
}

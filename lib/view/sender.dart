import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/controller/sender.dart';
import 'package:flutter_app/model/sender.dart';
import 'package:flutter_app/types/file.dart';

class SenderPage<T extends AbstractFile> extends StatefulWidget {
  final ISenderController<T> controller;

  SenderPage({this.controller});

  @override
  _SenderPageState createState() => _SenderPageState<T>(controller: controller);
}

class _SenderPageState<T extends AbstractFile> extends State<SenderPage> {
  final ISenderController<T> controller;

  _SenderPageState({this.controller});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("ファイル送信"),
      ),
      body: Center(
        child: Column(
          children: [
            _ReceiverSelector(
              controller: controller,
            ),
            _SendButton(
              controller: controller,
            ),
            _SendFileList<T>(
              controller: controller,
            )
          ],
        ),
      ),
    );
  }
}

class _ReceiverSelector extends StatefulWidget {
  final ISenderController controller;

  _ReceiverSelector({this.controller});

  @override
  _ReceiverSelectorState createState() => _ReceiverSelectorState(controller: controller);
}

class _ReceiverSelectorState extends State<_ReceiverSelector> {
  ISenderController controller;
  static const initialValue = "(Please choose one)";
  String selectedValue = initialValue;

  _ReceiverSelectorState({this.controller});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getReceiverNames(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          var cache = snapshot.data;
          cache.insert(0, initialValue);
          return selectorTemplate(cache);
        }
        return selectorTemplate([selectedValue]);
      },
    );
  }

  Widget selectorTemplate(List<String> contents) {
    return DropdownButton(
      value: selectedValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      onChanged: (String newValue) {
        setState(() {
          selectedValue = newValue;
        });
      },
      items: contents.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class _SendButton extends StatelessWidget {
  final ISenderController controller;

  _SendButton({this.controller});

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed:() {
        controller.onClickSendButton().then((isSuccess) {
          final statusText = isSuccess ? "Succeeded sending files!!!" : "Failed sending files...";
          showDialog(
              context: context,
              builder: (_) => sentDialog(context, statusText)
          );
        });
      },
      child: Text("Send"),
    );
  }

  Widget sentDialog(BuildContext context, String statusText) {
    return AlertDialog(
      title: Text("Sent files"),
      content: Text(statusText),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}

class _SendFileList<T extends AbstractFile> extends StatefulWidget {
  final ISenderController<T> controller;
  _SendFileList({this.controller});

  @override
  _SendFileListState createState() => _SendFileListState<T>(
    controller: controller,
  );
}

class _SendFileListState<T extends AbstractFile> extends State<_SendFileList> {
  final ISenderController<T> controller;
  List<T> _fileList;
  _SendFileListState({this.controller}) {
     _fileList = controller.getFiles();
  }

  @override
  Widget build(BuildContext context) {
    _fileList = controller.getFiles();
    return Expanded(
      child: ListView.builder(
        itemCount: _fileList.length,
        itemBuilder: (BuildContext context, int index) {
          final file = _fileList[index];
          return Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  file.getFileName(),
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                Text(
                  file.getFileSize().toString(),
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      setState(() {
                        controller.onDeleteFile(index);
                      }),
                  icon: Icon(Icons.delete),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class ViewTestController extends ISenderController<SenderTestFile> {
  ISenderModel<SenderTestFile> _model;

  List<SenderTestFile> _addedFiles = [
    SenderTestFile(fileName: "file1", fileSize: 1024),
    SenderTestFile(fileName: "file2", fileSize: 2048),
    SenderTestFile(fileName: "file3", fileSize: 2048),
  ];
  Map<String, String> _receivers = {};

  String selectedReceiversURL;
  static const _okCode = HttpStatus.ok;

  ViewTestController(ISenderModel<SenderTestFile> model) {
    this._model = model;
  }

  @override
  onAddNewFile(SenderTestFile file) {
    _addedFiles.add(file);
  }

  @override
  Future<bool> onClickSendButton() async {
    if (selectedReceiversURL == null)
      return false;

    return _okCode == await _model.sendFiles(_addedFiles, selectedReceiversURL);
  }

  @override
  onSelectReceiver(String receiver) {
    if (!_receivers.containsKey(receiver))
      throw NullThrownError();
    selectedReceiversURL = _receivers[receiver];
  }

  @override
  Future<List<String>> getReceiverNames() async {
    _receivers = await _model.getServers();
    return _receivers.keys.toList();
  }

  @override
  onDeleteFile(int index)  {
    _addedFiles.removeAt(index);
  }

  @override
  List<SenderTestFile> getFiles() {
    return _addedFiles;
  }
}

class SenderTestFile extends AbstractFile {
  String fileName;
  int fileSize;

  SenderTestFile({this.fileName, this.fileSize});

  String getFileName() => fileName;
  int getFileSize() => fileSize;
}

class SenderViewTestModel<T extends AbstractFile> implements ISenderModel<T> {
  Future<Map<String, String>> getServers() async {
    return {
      "Server": "address",
      "Unchi": "ip"
    };
  }

  Future<int> sendFiles(List<T> file, String url) async {
    if (file.isEmpty) {
      return 204;
    }

    return 200;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/controller/sender.dart';
import 'package:flutter_app/types/file.dart';

class SenderPage<T extends OriginalFile> extends StatefulWidget {
  final ISenderController<T> controller;

  const SenderPage({Key key, this.controller}) : super(key: key);

  @override
  _SenderPageState createState() => _SenderPageState();
}

class _SenderPageState<T extends OriginalFile> extends State<SenderPage> {
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
  _ReceiverSelectorState createState() => _ReceiverSelectorState();
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
      }),
    );
  }
}

class _SendButton extends StatelessWidget {
  final ISenderController controller;

  _SendButton({this.controller});

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: () {
        controller.onClickSendButton().then((isSuccess) {
          var statusText = "";
          statusText = isSuccess ? "Succeeded sending files!!!" : "Failed sending files...";
          showDialog(
              context: context,
              builder: (_) {
                return sentDialog(context, statusText);
              });
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

class _SendFileList<T extends OriginalFile> extends StatefulWidget {
  final List<T> fileList;
  final ISenderController<T> controller;
  _SendFileList({this.fileList, this.controller});

  @override
  _SendFileListState createState() => _SendFileListState();
}

class _SendFileListState<T extends OriginalFile> extends State<_SendFileList> {
  final List<T> fileList;
  final ISenderController<T> controller;
  _SendFileListState({this.fileList, this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: fileList.length,
        itemBuilder: (BuildContext context, int index) {
          return _FileCard(
            file: fileList[index],
            index: index,
            controller: controller,
          );
        },
      ),
    );
  }
}

class _FileCard<T extends OriginalFile> extends StatelessWidget {
  final ISenderController<T> controller;
  final T file;
  final int index;
  _FileCard({this.controller, this.file, this.index});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () => controller.onDeleteFile(index),
            icon: Icon(Icons.delete),
          )
        ],
      ),
    );
  }
}

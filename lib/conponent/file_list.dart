import 'package:flutter/material.dart';
import 'package:flutter_app/controller/sender.dart';
import 'package:flutter_app/types/file.dart';

class FileList<T extends AbstractFile> extends StatefulWidget {
  final ISenderController<T> controller;
  FileList({this.controller});

  @override
  _FileListState createState() => _FileListState();
}

class _FileListState<T extends AbstractFile> extends State<FileList> {
  final ISenderController<T> controller;
  _FileListState({this.controller});

  @override
  Widget build(BuildContext context) {
    List<T> files = controller.getFiles();
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _FileListItem(
            item: files[index],
          );
        },
        itemCount: files.length,
      ),
    );
  }
}

class _FileListItem<T extends AbstractFile> extends StatelessWidget {
  final T item;
  _FileListItem({this.item});

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.getFileName(),
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            item.getFileSize().toString(),
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}

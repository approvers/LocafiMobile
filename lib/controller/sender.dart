import 'dart:io';

import 'package:flutter_app/model/sender.dart';

class SenderController implements ISenderController {
  ISenderModel _model;

  List<File> _addedFiles;
  Map<String, String> _receivers;

  String selectedReceiversURL;
  static const _okCode = "200";

  SenderController(ISenderModel model) {
    this._model = model;
  }

  @override
  onAddNewFile(File file) {
    _addedFiles.add(file);
  }

  @override
  Future<bool> onClickSendButton() async {
    if (selectedReceiversURL == null) {
      return false;
    }

    return _okCode == await _model.sendFiles(_addedFiles, selectedReceiversURL);
  }

  @override
  onSelectReceiver(String receiver) {
    selectedReceiversURL = _receivers[receiver];
  }

  @override
  Future<List<String>> getReceiverNames() async {
    _receivers = await _model.getServers();
    return _receivers.keys.toList();
  }

  @override
  onDeleteFile(int index) {
    _addedFiles.removeAt(index);
  }
}

abstract class ISenderController {
  Future<List<String>> getReceiverNames();

  onSelectReceiver(String receiver);

  onAddNewFile(File file);

  onDeleteFile(int index);

  Future<bool> onClickSendButton();
}
import 'dart:io';

import 'package:locafiMobile/model/sender.dart';

class SenderController<T> implements ISenderController<T> {
  ISenderModel<T> _model;

  List<T> _addedFiles = [];
  Map<String, String> _receivers = {};

  String selectedReceiversURL;
  static const _okCode = HttpStatus.ok;

  SenderController(ISenderModel model) {
    this._model = model;
  }

  @override
  onAddNewFile(T file) {
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
  onDeleteFile(int index) => _addedFiles.removeAt(index);

  @override
  List<T> getFiles() {
    return _addedFiles;
  }
}

abstract class ISenderController<T> {
  Future<List<String>> getReceiverNames();

  List<T> getFiles();

  onSelectReceiver(String receiver);

  onAddNewFile(T file);

  onDeleteFile(int index);

  Future<bool> onClickSendButton();
}

import 'dart:io';

abstract class ISenderController {
  List<String> receiverNames();

  onSelectReceiver(String receiver);

  onAddNewFile(File file);

  Future<bool> onClickSendButton();
}
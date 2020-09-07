import 'package:locafi_mobile/model/receiver.dart';
import 'package:locafi_mobile/types/file.dart';

class ReceiverController<T extends AbstractFile> implements IReceiverController<T> {
  IReceiverServerModel _receiverServerModel;
  IReceiverFileSaverModel _receiverFileSaverModel;

  List<T> receivedFiles = [];

  ReceiverController(IReceiverServerModel serverModel, IReceiverFileSaverModel saverModel) {
    this._receiverServerModel = serverModel;
    this._receiverFileSaverModel = saverModel;
  }

  @override
  bool deleteFile(int index) {
    try {
      final file = this.receivedFiles.removeAt(index);
      return file != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> finishServer() async =>
      await this._receiverServerModel.finishServer();

  @override
  List<T> getFileList() => [...this.receivedFiles];

  @override
  Future<bool> saveFile(int index) async {
    try {
      final file = this.receivedFiles[index];

      return this._receiverFileSaverModel.saveFile(file);
    } catch(e) {
      return false;
    }
  }

  @override
  Future<bool> startServer(String serverName) async {
    return await this._receiverServerModel.startServer(serverName);
  }

  @override
  Future<List<T>> waitFiles() async {
    final receivedFiles = await this._receiverServerModel.getFileList();
    receivedFiles.forEach((newFile) {
      this.receivedFiles.add(newFile);
    });

    return receivedFiles;
  }

}

abstract class IReceiverController<T extends AbstractFile> {
  List<T> getFileList();

  bool deleteFile(int index);

  Future<List<T>> waitFiles();

  Future<bool> saveFile(int index);

  Future<bool> startServer(String serverName);

  Future<bool> finishServer();
}

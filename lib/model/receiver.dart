import 'package:locafi_mobile/types/file.dart';

abstract class IReceiverServerModel<T extends AbstractFile> {
  Future<List<T>> getFileList();

  Future<bool> startServer(String serverName);

  Future<bool> finishServer();
}

abstract class IReceiverFileSaverModel<T extends AbstractFile> {
  Future<bool> saveFile(T file);
}

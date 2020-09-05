import 'package:locafi_mobile/types/file.dart';

abstract class IReceiverModel<T extends AbstractFile> {
  Future<List<T>> getFileList();

  Future<bool> startServer(String serverName);

  Future<bool> finishServer();
}

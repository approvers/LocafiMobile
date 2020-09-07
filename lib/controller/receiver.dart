import 'package:locafi_mobile/types/file.dart';

abstract class IReceiverController<T extends AbstractFile> {
  List<T> getFileList();

  bool deleteFile(int index);

  Future<List<T>> waitFiles();

  Future<bool> saveFile(T file);

  Future<bool> startServer(String serverName);

  Future<bool> finishServer();
}

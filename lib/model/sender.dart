import 'package:locafi_mobile/types/file.dart';

abstract class ISenderModel<T extends AbstractFile> {
  Future<Map<String, String>> getServers();

  Future<int> sendFiles(List<T> file, String url);
}

import 'package:locafi_mobile/types/file.dart';

class TestingFile extends AbstractFile {
  final String fileName;
  final int fileSize;

  TestingFile({this.fileName, this.fileSize});

  @override
  String getFileName() => this.fileName;

  @override
  int getFileSize() => this.fileSize;
}

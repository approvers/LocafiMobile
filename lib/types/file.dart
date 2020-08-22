import 'dart:io';

class OriginalFile implements AbstractFile{
  String fileName;
  int fileSize;

  OriginalFile(File file) {
    fileName = createFileNameFromPath(file.path);
    fileSize = file.lengthSync();
  }

  String createFileNameFromPath(String path) {
    List<String> pathList = path.split("/");
    return pathList[-1];
  }

  String getFileName() => fileName;

  int getFileSize() => fileSize;
}

abstract class AbstractFile {
  String getFileName();
  int getFileSize();
}

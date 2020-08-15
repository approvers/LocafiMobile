import 'dart:io';

abstract class ISenderModel {
  Future<Map<String, String>> getServers();

  Future<String> sendFiles(List<File> file, String url);
}
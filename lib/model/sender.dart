import 'dart:io';

abstract class ISenderModel {
  Future<String> getServers();

  Future<String> sendFiles(List<File> file);
}
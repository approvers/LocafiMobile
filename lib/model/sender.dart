abstract class ISenderModel<T> {
  Future<Map<String, String>> getServers();

  Future<String> sendFiles(List<T> file, String url);
}

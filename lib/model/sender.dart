abstract class ISenderModel<T> {
  Future<Map<String, String>> getServers();

  Future<int> sendFiles(List<T> file, String url);
}
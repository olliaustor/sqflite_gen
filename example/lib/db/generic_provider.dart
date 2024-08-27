abstract class GenericProvider<T> {
  List<String> create(int version);

  Future<T> insert(T general);
  Future<T?> get(int id);
  Future<int> delete(int id);
  Future<int> update(T general);
}

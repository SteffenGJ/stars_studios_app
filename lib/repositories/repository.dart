abstract class Repository<T> {
  Future<T> fetch(String id);
  Future<void> create(String id, T data);
  Future<void> update(String id, T data);
  Future<void> delete(T data);
}

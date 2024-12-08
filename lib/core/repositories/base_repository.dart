abstract class BaseRepository<T> {
  Future<T?> getById(String id);
  Future<List<T>> getAll();
  Future<T> create(T item);
  Future<T> update(T item);
  Future<bool> delete(String id);
}

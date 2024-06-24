abstract class LocalStorage {
  Future<void> clear();
  Future<V?> read<V>(String key);
  Future<void> write<V> (String key, V value);
  Future<bool> contain(String key);
  Future<void> remove(String key);
}

abstract class LocalSecureStorage{
   Future<void> clear();
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<bool> contain(String key);
  Future<void> remove(String key);

}
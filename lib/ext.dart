extension MappingKey<T> on Map<String, dynamic> {
  T get(String key, T defaultValue) {
    if (containsKey(key)) {
      return this[key];
    } else {
      return defaultValue;
    }
  }
}
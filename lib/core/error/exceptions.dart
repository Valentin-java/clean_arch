/// Исключение, выбрасываемое при ошибке получения данных.
class DataFetchException implements Exception {
  final String message;

  DataFetchException(this.message);
}

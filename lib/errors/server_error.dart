class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Error en el servidor']);
  @override
  String toString() => message;
}

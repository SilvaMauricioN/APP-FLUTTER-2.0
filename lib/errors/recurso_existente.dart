class RecursoExistenteException implements Exception {
  final String message;
  final int statusCode = 409;

  RecursoExistenteException(
      [this.message = 'El recurso que intenta crear ya existe.']);

  @override
  String toString() => 'ConflictException: $message (Status: $statusCode)';
}

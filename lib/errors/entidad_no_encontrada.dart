class EntidadNoEncontradaException implements Exception {
  final String message;
  final String detail;
  final int statusCode = 404;

  EntidadNoEncontradaException(this.message, this.detail);

  @override
  String toString() =>
      'EntidadNoEncontradaException: $message (Status: $statusCode)';
}

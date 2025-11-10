class EntidadNoEncontradaException implements Exception {
  final String message;
  final String detail;

  EntidadNoEncontradaException(this.message, this.detail);

  @override
  String toString() => 'EntidadNoEncontradaException: $message - $detail';
}

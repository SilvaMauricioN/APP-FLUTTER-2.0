class ObraNoEncontradaException implements Exception {
  final String mensaje;
  final String detalle;

  ObraNoEncontradaException(this.mensaje, this.detalle);

  @override
  String toString() => 'ObraNoEncontradaException: $mensaje - $detalle';
}

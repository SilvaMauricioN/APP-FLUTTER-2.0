class Paginacion {
  final int resultadoTotal;
  final int paginaActual;
  final int limite;
  final int paginasTotales;

  Paginacion({
    required this.resultadoTotal,
    required this.paginaActual,
    required this.limite,
    required this.paginasTotales,
  });

  factory Paginacion.fromJson(Map<String, dynamic> json) {
    return Paginacion(
      resultadoTotal: json['resultadoTotal'],
      paginaActual: json['paginaActual'],
      limite: json['limite'],
      paginasTotales: json['paginasTotales'],
    );
  }

  bool get hayPaginaSiguiente => paginaActual < paginasTotales;
  bool get hayPaginaAnterior => paginaActual > 1;
}

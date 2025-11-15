import './paginacion_model.dart';

class ApiResponse<T> {
  final String status;
  final String? message;
  final bool? hayResultado;
  final Paginacion? paginacion;
  final List<T>? data;
  final T? item;
  final String? detalle;

  ApiResponse(
      {required this.status,
      required this.message,
      this.hayResultado,
      this.paginacion,
      this.data,
      this.item,
      this.detalle});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return ApiResponse<T>(
      status: json['status'] as String,
      message: json['message'] ?? 'sin mensaje',
      hayResultado: json['hayResultado'],
      paginacion: json['paginacion'] != null
          ? Paginacion.fromJson(json['paginacion'])
          : null,
      data: json['data'] != null
          ? (json['data'] as List<dynamic>)
              .map((e) => fromJsonT(e as Map<String, dynamic>))
              .toList()
          : null,
      detalle: (json['detalle'] as String?) ?? '',
    );
  }

  factory ApiResponse.fromJsonSingle(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return ApiResponse<T>(
      status: json['status'] ?? '',
      message: json['mensaje'] ?? json['message'],
      hayResultado: json['hayResultado'],
      paginacion: json['paginacion'] != null
          ? Paginacion.fromJson(json['paginacion'])
          : null,
      item: json['data'] != null
          ? fromJsonT(json['data'] as Map<String, dynamic>)
          : null,
      detalle: json['detalle'] ?? 'Sin detalle',
    );
  }

  factory ApiResponse.error({
    required String mensaje,
    required String detalle,
  }) =>
      ApiResponse(
        status: 'error',
        message: mensaje,
        detalle: detalle,
      );

  bool get isSuccess => status == 'success';
  bool get tieneResultados =>
      hayResultado == true || (data != null && data!.isNotEmpty);
}

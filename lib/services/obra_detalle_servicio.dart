import 'package:app_demo/screens/screens.dart';

class ObraDetalleServicio {
  final String baseUrl = ApiConfig.baseUrl;
  final Map<String, String> headers = ApiConfig.defaultHeaders;
  //final url = Uri.parse('$baseUrl/obra/$objectNumber');
  final ApiService apiService =
      ApiService(baseUrl: ApiConfig.baseUrl, headers: ApiConfig.defaultHeaders);

  Future<ApiResponse<ObraDetalle>> getObraDetallePorId(String objectNumber) {
    return apiService.getDatos<ObraDetalle>(
      endpoint: 'obra/$objectNumber',
      fromJson: (json) => ObraDetalle.fromJson(json),
      errorContext: 'Obra',
    );
  }
}

//import 'package:http/http.dart' as http;
import '../screens/screens.dart';

class OcupacionServicio {
  final String baseUrl = ApiConfig.baseUrl;
  final Map<String, String> headers = ApiConfig.defaultHeaders;
  final ApiService apiService =
      ApiService(baseUrl: ApiConfig.baseUrl, headers: ApiConfig.defaultHeaders);

  Future<ApiResponse<Ocupacion>> getOcupaciones() {
    return apiService.getDatos(
        endpoint: 'ocupaciones',
        fromJson: (json) => Ocupacion.fromJson(json),
        errorContext: 'coleccion ocupaciones');
  }
}

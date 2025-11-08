import 'package:http/http.dart' as http;
import 'package:app_demo/screens/screens.dart';

class ObraDetalleServicio {
  final String baseUrl = ApiConfig.baseUrl;
  final Map<String, String> headers = ApiConfig.defaultHeaders;
  //final url = Uri.parse('$baseUrl/obra/$objectNumber');

  Future<ObraDetalle> getObraDetallePorId(String objectNumber) async {
    final response = await http.get(
      Uri.parse('$baseUrl/obra/$objectNumber'),
      headers: headers,
    );

    if (response.statusCode != 200) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);

      if (response.statusCode == 404) {
        final detalle = jsonBody['detalle'] ?? 'Obra no encontrada';

        throw ObraNoEncontradaException(
            "La obra solicitada nose encuentra", detalle);
      }
      throw ServerException(
          'Ocurrió un error al cargar la obra. Inténtalo de nuevo.');
    }

    final Map<String, dynamic> jsonBody = json.decode(response.body);
    final data = jsonBody['data'];

    if (data == null || data.isEmpty) {
      throw ObraNoEncontradaException(
          'Obra no encontrada', jsonBody['detale'] ?? 'Sin detalle');
    }

    return ObraDetalle.fromJson(data);
  }
}

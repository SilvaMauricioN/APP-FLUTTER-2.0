import 'package:http/http.dart' as http;
import 'package:app_demo/screens/screens.dart';

class ObraDetalleServicio {
  final String baseUrl = ApiConfig.baseUrl;
  final Map<String, String> headers = ApiConfig.defaultHeaders;
  //final url = Uri.parse('$baseUrl/obra/$objectNumber');

  Future<ObraDetalle> getObraDetallePorId(String objectNumber) async {
    try {
      print('id en servicio ObraDetalle: $objectNumber');
      final response = await http.get(
        Uri.parse('$baseUrl/obra/$objectNumber'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);
        debugPrint(response.body, wrapWidth: 50);

        // manejar respuesta con "status" y "data"
        if (jsonBody.containsKey('status') && jsonBody['status'] == 'success') {
          final data = jsonBody['data'];
          if (data is List && data.isNotEmpty) {
            return ObraDetalle.fromJson(data.first);
          } else {
            throw Exception('No se encontró la obra solicitada.');
          }
        } else {
          // respuesta directa del objeto
          return ObraDetalle.fromJson(jsonBody);
        }
      } else {
        throw Exception(
            'Error nuevo ${response.statusCode}: ${response.reasonPhrase ?? 'Error desconocido'}');
      }
    } catch (e) {
      throw Exception('Error al conectar con la API: $e');
    }
  }

  // ApiResponse<T> _handleResponse<T>(
  //   http.Response response,
  //   T Function(Map<String, dynamic>) fromJson,
  // ) {
  //   // Respuesta exitosa (200-299)
  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
  //     return ApiResponse<T>.fromJson(jsonResponse, fromJson);
  //   }
  //   // Error del cliente (400-499): solicitud incorrecta, no autorizado, no encontrado, etc.
  //   else if (response.statusCode >= 400 && response.statusCode < 500) {
  //     try {
  //       final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
  //       return ApiResponse<T>.fromJson(jsonResponse, fromJson);
  //     } catch (e) {
  //       throw Exception(
  //         'Error ${response.statusCode}: ${response.body}',
  //       );
  //     }
  //   }
  //   // Error del servidor (500-599)
  //   else if (response.statusCode >= 500) {
  //     throw Exception(
  //       'Error del servidor (${response.statusCode}): ${response.body}',
  //     );
  //   }
  //   // Otros códigos de estado inesperados
  //   else {
  //     throw Exception(
  //       'Respuesta inesperada (${response.statusCode}): ${response.body}',
  //     );
  //   }
  // }
}

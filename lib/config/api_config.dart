import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  // Base URL
  static String get baseUrl => dotenv.env['API_BASE_URL'] ?? '';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';

  // Endpoints
  static const String makersEndpoint = '/makers';
  static const String artworksEndpoint = '/artworks';

  // API Key (si usas)

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Headers por defecto
  static Map<String, String> get defaultHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'api-Key': apiKey,
      };

  // URLs completas
  static String get makersUrl => '$baseUrl$makersEndpoint';
  static String get artworksUrl => '$baseUrl$artworksEndpoint';
}

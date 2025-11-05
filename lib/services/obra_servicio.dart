import '../screens/screens.dart';
import 'package:http/http.dart' as http;

class ObraServicio {
  final String baseUrl = ApiConfig.baseUrl;
  final Map<String, String> headers = ApiConfig.defaultHeaders;

  Future<ApiResponse<Obra>> getColeccionObras(
      {int pagina = 1, int limite = 20}) async {
    final response = await http.get(
        Uri.parse('$baseUrl/obras/coleccion?pagina=$pagina&limite=$limite'),
        headers: headers);

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(
        json.decode(response.body),
        (json) => Obra.fromJson(json),
      );
    }
    throw Exception('Nose puede cargar obras');
  }

  // GET - Lista de obras
//   Future<List<Obra>> getColeccionObras({int page = 1, int limit = 20}) async {
//     try {
//       final response = await http.get(
//           Uri.parse('$baseUrl/obras/coleccion?pagina=$page&limite=$limit'),
//           headers: headers);
//
//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         final List<dynamic> data = jsonData['data'];
//         return data.map((json) => Obra.fromJson(json)).toList();
//       } else {
//         throw Exception(
//             'Error ${response.statusCode}: ${response.reasonPhrase}');
//       }
//     } catch (error) {
//       throw Exception('Error de conexion: $error');
//     }
//   }

  // GET - Detalle de una obra
  Future<ObraDetalle> getObraDetalle(String objectNumber) async {
    final response = await http.get(
      Uri.parse('$baseUrl/artworks/$objectNumber'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return ObraDetalle.fromJson(jsonData['data'][0]);
    }
    throw Exception('Error al cargar detalle de obra');
  }

  // POST - Crear obra (necesitas enviar obra + imagen + fecha + títulos)
  Future<ObraDetalle> postObra({
    required ObraDetalle obra,
    required Img img,
    required Fecha fecha,
    List<TituloAlternativo>? listaTitulosAlter,
  }) async {
    // 1. Crear la obra principal
    final obraRes = await http.post(
      Uri.parse('$baseUrl/artworks'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(obra.toJson()),
    );

    if (obraRes.statusCode != 201) {
      throw Exception('Error al crear obra');
    }

    final obraCreada = json.decode(obraRes.body);
    final idArtObject = obraCreada['data']['idartobject'];

    // 2. Agregar imagen
    await http.post(
      Uri.parse('$baseUrl/artworks/$idArtObject/image'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'IdArtObject': idArtObject,
        ...img.toJson(),
      }),
    );

    // 3. Agregar fecha
    await http.post(
      Uri.parse('$baseUrl/artworks/$idArtObject/dating'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'IdArtObject': idArtObject,
        ...fecha.toJson(),
      }),
    );

    // 4. Agregar títulos alternativos
    if (listaTitulosAlter != null) {
      for (var alternativeTitle in listaTitulosAlter) {
        await http.post(
          Uri.parse('$baseUrl/artworks/$idArtObject/alternative-title'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'IdArtObject': idArtObject,
            ...alternativeTitle.toJson(),
          }),
        );
      }
    }

    return getObraDetalle(obraCreada['data']['objectnumber']);
  }

  // PUT - Actualizar obra
  Future<ObraDetalle> updateArtwork(
    String objectNumber,
    Obra obra,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/artworks/$objectNumber'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(obra.toJson()),
    );

    if (response.statusCode == 200) {
      return getObraDetalle(objectNumber);
    }
    throw Exception('Error al actualizar obra');
  }

  // PATCH - Actualización parcial
  Future<ObraDetalle> patchArtwork(
    String objectNumber,
    Map<String, dynamic> fields,
  ) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/artworks/$objectNumber'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(fields),
    );

    if (response.statusCode == 200) {
      return getObraDetalle(objectNumber);
    }
    throw Exception('Error al actualizar obra');
  }
}

import 'package:http/http.dart' as http;
import 'package:app_demo/screens/screens.dart';

class MuseumService with ChangeNotifier {
  final String baseUrl = 'https://museo-dwgk.onrender.com/api/museorijks';
  static const Map<String, String> defaultHeaders = {
    'api-key': 'NjSSMo3S0L',
    'Content-Type': 'application/json',
  };

  // final String baseUrl = 'https://museorijks.onrender.com/api/MuseoRijks';

  Future<List<Artistas>> getArtistas() async {
    final response = await http.get(
        Uri.parse(
          '$baseUrl/Artistas',
        ),
        headers: defaultHeaders);

    if (response.statusCode == 200) {
      List<Artistas> listaArtistas = artistasFromJson(response.body);
      return listaArtistas;
    } else {
      throw Exception('Error al Cargar  los Artistas');
    }
  }

  Future<List<Obra>> getObrasPorArtista(String nombreArtista) async {
    final response = await http.get(
        Uri.parse('$baseUrl/collecion/Artista?artista=$nombreArtista'),
        headers: defaultHeaders);

    if (response.statusCode == 200) {
      List<Obra> listaObrasArtista = obrasSimpleFromJson(response.body);
      return listaObrasArtista;
    } else {
      throw Exception('Error al Cargar las Obras del Artista');
    }
  }

  Future<ObraDetalle> getObraPorId(String id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/Obra/$id'), headers: defaultHeaders);

    if (response.statusCode == 200) {
      ObraDetalle obraArtista = obraDetalleFromJson(response.body);

      return obraArtista;
    } else {
      throw Exception('Error al Cargar la Obra');
    }
  }

  Future<List<Obra>> getColeccion() async {
    final response = await http.get(Uri.parse('$baseUrl/obras/coleccion'),
        headers: defaultHeaders);

    if (response.statusCode == 200) {
      List<Obra> listaColecionObras = obrasSimpleFromJson(response.body);
      return listaColecionObras;
    } else {
      throw Exception('Error al Cargar la Coleccion');
    }
  }
}

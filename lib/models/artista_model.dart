import '../screens/screens.dart';
import 'dart:convert';

//De json a lista objeto Artistas
List<Artista> artistasFromJson(String str) {
  final Map<String, dynamic> jsonResponse = json.decode(str);
  List<dynamic> jsonList = jsonResponse['data'];
  List<Artista> artistasLista =
      List<Artista>.from(jsonList.map((x) => Artista.fromJson(x)));
  return artistasLista;
}

//De objeto Artista a Json
String artistasToJson(List<Artista> data) {
  List<Map<String, dynamic>> artistasMapList =
      List<Map<String, dynamic>>.from(data.map((x) => x.toJson()));
  String jsonString = json.encode(artistasMapList);
  return jsonString;
}

class Artista {
  int idPrincipalMaker;
  String name;
  String placeOfBirth;
  String dateOfBirth;
  String dateOfDeath;
  String placeOfDeath;
  String nationality;
  // List<String> occupations;

  Artista({
    required this.idPrincipalMaker,
    required this.name,
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.dateOfDeath,
    required this.placeOfDeath,
    required this.nationality,
    // required this.occupations
  });
  //permite crear una instancia de la clase Artistas a partir de un mapa (Map) que representa un objeto JSON.
  factory Artista.fromJson(Map<String, dynamic> json) => Artista(
        idPrincipalMaker: json["IdPrincipalMaker"],
        name: json["name"],
        placeOfBirth: json['placeOfBirth'],
        dateOfBirth: json['dateOfBirth'],
        dateOfDeath: json['dateOfDeath'],
        placeOfDeath: json['placeOfDeath'],
        nationality: json['nationality'],
        // occupations: json['occupatons']
      );

  //convierte una instancia de la clase Artistas en un mapa (Map) que puede ser fácilmente convertido a formato JSON.
  Map<String, dynamic> toJson() => {
        'IdPrincipalMaker': idPrincipalMaker,
        'name': name,
        'placeOfBirth': placeOfBirth,
        'dateOfBirth': dateOfBirth,
        'dateOfDeath': dateOfDeath,
        'placeOfDeath': placeOfDeath,
        'nationality': nationality,
        // 'occupations': occupations
      };
}

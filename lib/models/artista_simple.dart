import 'dart:convert';

//De json a lista objeto Artistas
List<Artistas> artistasFromJson(String str) {
  final Map<String, dynamic> jsonResponse = json.decode(str);
  List<dynamic> jsonList = jsonResponse['data'];
  List<Artistas> artistasLista =
      List<Artistas>.from(jsonList.map((x) => Artistas.fromJson(x)));
  return artistasLista;
}

//De objeto Artista a Json
String artistasToJson(List<Artistas> data) {
  List<Map<String, dynamic>> artistasMapList =
      List<Map<String, dynamic>>.from(data.map((x) => x.toJson()));
  String jsonString = json.encode(artistasMapList);
  return jsonString;
}

class Artistas {
  int idprincipalmaker;
  String name;
  String placeOfBirth;
  String dateOfBirth;
  String dateOfDeath;
  String placeOfDeath;
  String nationality;
  List<String> occupations;

  Artistas(
      {required this.idprincipalmaker,
      required this.name,
      required this.placeOfBirth,
      required this.dateOfBirth,
      required this.dateOfDeath,
      required this.placeOfDeath,
      required this.nationality,
      required this.occupations});
  //permite crear una instancia de la clase Artistas a partir de un mapa (Map) que representa un objeto JSON.
  factory Artistas.fromJson(Map<String, dynamic> json) => Artistas(
      idprincipalmaker: json["idprincipalmaker"],
      name: json["name"],
      placeOfBirth: json['placeOfBirth'],
      dateOfBirth: json['dateOfBirth'],
      dateOfDeath: json['dateOfDeath'],
      placeOfDeath: json['placeOfDeath'],
      nationality: json['nationality'],
      occupations: json['occupatons']);

  //convierte una instancia de la clase Artistas en un mapa (Map) que puede ser fácilmente convertido a formato JSON.
  Map<String, dynamic> toJson() => {
        'name': name,
        'placeOfBirth': placeOfBirth,
        'dateOfBirth': dateOfBirth,
        'dateOfDeath': dateOfDeath,
        'placeOfDeath': placeOfDeath,
        'nationality': nationality,
        'occupations': occupations
      };
}

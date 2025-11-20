import '../screens/screens.dart';
//import 'dart:convert';

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
  int? idPrincipalMaker;
  String name;
  String? placeOfBirth;
  String? dateOfBirth;
  String? dateOfDeath;
  String? placeOfDeath;
  String? nationality;
  List<Ocupacion> occupations;

  Artista({
    this.idPrincipalMaker,
    required this.name,
    this.placeOfBirth,
    this.dateOfBirth,
    this.dateOfDeath,
    this.placeOfDeath,
    this.nationality,
    required this.occupations, //this.occupations = const []
  });

  Artista.nuevo({
    required this.name,
    this.placeOfBirth,
    this.dateOfBirth,
    this.dateOfDeath,
    this.placeOfDeath,
    this.nationality,
    required this.occupations,
  });

  //get
  factory Artista.fromJson(Map<String, dynamic> json) => Artista(
      idPrincipalMaker: json["IdPrincipalMaker"] as int,
      name: json["name"] as String,
      placeOfBirth: (json['placeOfBirth'] as String).isNotEmpty == true
          ? json['placeOfBirth']
          : 'Desconocido',
      dateOfBirth: json['dateOfBirth'] as String,
      dateOfDeath: json['dateOfDeath'] as String,
      placeOfDeath: json['placeOfDeath'] as String,
      nationality: json['nationality'] as String,
      occupations: _parseOcupacion(json["occupations"]));

  //Respuesta POST
  factory Artista.fromPostResponseJson(Map<String, dynamic> json) {
    return Artista(
      idPrincipalMaker: json['idprincipalmaker'],
      name: json['name'],
      placeOfBirth: json['placeofbirth'],
      dateOfBirth: json['dateofbirth'],
      dateOfDeath: json['dateofdeath'],
      placeOfDeath: json['placeofdeath'],
      nationality: json['nationality'],
      occupations: Artista._parseOcupacion(json['occupations']),
    );
  }

  //  POST
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'placeOfBirth': placeOfBirth,
      'dateOfBirth': dateOfBirth,
      'dateOfDeath': dateOfDeath,
      'placeOfDeath': placeOfDeath,
      'nationality': nationality,
      'occupations':
          occupations.map((o) => o.id).where((id) => id != null).toList(),
    };
  }

  static List<Ocupacion> _parseOcupacion(dynamic value) {
    if (value == null) return [];

    // Si es lista de objetos
    if (value is List && value.isNotEmpty && value.first is Map) {
      return value
          .map((e) => Ocupacion.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    // Si es lista de strings
    if (value is List && value.isNotEmpty && value.first is String) {
      return value.map((e) => Ocupacion.fromString(e)).toList();
    }

    return [];
  }

  @override
  String toString() {
    return 'Artista {\n'
        '  ID: $idPrincipalMaker,\n'
        '  Nombre: $name,\n'
        '  Lugar De Nacimiento: $placeOfBirth,\n'
        '  Fecha De Nacimiento: ($dateOfBirth),\n'
        '  Lugar De Muerte: $placeOfDeath,\n'
        '  Fecha De Muerte: ($dateOfDeath),\n'
        '  Nacionalidad: $nationality,\n'
        '  Ocupaciones: ${occupations.toString()}\n'
        '}';
  }
}

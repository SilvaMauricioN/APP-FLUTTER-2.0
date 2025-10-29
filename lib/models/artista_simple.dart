import 'dart:convert';

//De json a lista objeto Artistas
List<Artistas> artistasFromJson(String str) {
  List<dynamic> jsonList = json.decode(str);
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
  String key;
  int value;

  Artistas({
    required this.key,
    required this.value,
  });
  //permite crear una instancia de la clase Artistas a partir de un mapa (Map) que representa un objeto JSON.
  factory Artistas.fromJson(Map<String, dynamic> json) => Artistas(
        key: json["idprincipalmaker"],
        value: json["name"],
      );
  //convierte una instancia de la clase Artistas en un mapa (Map) que puede ser fácilmente convertido a formato JSON.
  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}

import 'dart:convert';
import 'img.dart';

//De json a lista  objeto ObraSimple
List<Obra> obrasSimpleFromJson(String str) {
  final Map<String, dynamic> jsonResponse = json.decode(str);
  List<dynamic> jsonList = jsonResponse['data'];
  List<Obra> listaObras =
      List<Obra>.from(jsonList.map((x) => Obra.fromJson(x)));
  return listaObras;
}

//De objeto ObraSimple a lista Json
String listaObraSimpleToJson(List<Obra> data) {
  List<Map<String, dynamic>> obraSimpleMapLista =
      List<Map<String, dynamic>>.from(data.map((x) => x.toJson()));
  String jsonString = json.encode(obraSimpleMapLista);
  return jsonString;
}

String obraSimpleToJson(List<Obra> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Obra {
  String objectNumber;
  String title;
  bool hasImage;
  String principalOrFirstMaker;
  String longTitle;
  Img webImage;

  Obra({
    required this.objectNumber,
    required this.title,
    required this.hasImage,
    required this.principalOrFirstMaker,
    required this.longTitle,
    required this.webImage,
  });

  //Constructor para crear una instancia desde JSON
  factory Obra.fromJson(Map<String, dynamic> json) => Obra(
        objectNumber: json["objectnumber"] as String,
        title: json["title"] as String,
        hasImage: json["hasimage"],
        principalOrFirstMaker: json["principalOrFirstMaker"] as String,
        longTitle: json["longtitle"] as String,
        webImage: json["webImage"] != null
            ? Img.fromJson(json["webImage"])
            : Img(width: 0, height: 0, url: ""),
      );

  // Método para convertir la instancia a JSON
  Map<String, dynamic> toJson() => {
        "objectNumber": objectNumber,
        "title": title,
        "hasImage": hasImage,
        "principalOrFirstMaker": principalOrFirstMaker,
        "longTitle": longTitle,
        "webImage": webImage.toJson(),
      };

  //De json a lista  objeto ObraSimple
  static List<Obra> listaObrasFromJson(String str) {
    final Map<String, dynamic> jsonResponse = json.decode(str);
    final List<dynamic> data = jsonResponse['data'];
    List<Obra> listaObras = List<Obra>.from(data.map((x) => Obra.fromJson(x)));
    return listaObras;
  }
}

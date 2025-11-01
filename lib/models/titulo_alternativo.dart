class TituloAlternativo {
  int? idOtherTitle;
  int? idArtObject;
  String alternativeTitle;
  String titleType;

  TituloAlternativo({
    this.idOtherTitle,
    this.idArtObject,
    required this.alternativeTitle,
    required this.titleType,
  });

  factory TituloAlternativo.fromJson(Map<String, dynamic> json) =>
      TituloAlternativo(
          idArtObject: json["idArtObject"],
          alternativeTitle: json["alternativeTitle"],
          titleType: json["titleType"]);

  Map<String, dynamic> toJson() => {
        "IdArtObject": idArtObject,
        "alternativeTitle": alternativeTitle,
        "titleType": titleType,
      };
}

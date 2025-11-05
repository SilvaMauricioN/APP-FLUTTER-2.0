import '../screens/screens.dart';

ObraDetalle obraDetalleFromJson(String str) =>
    ObraDetalle.fromJson(json.decode(str));

String obraDetalleToJson(ObraDetalle data) => json.encode(data.toJson());

class ObraDetalle {
  String objectNumber;
  String title;
  String longTitle;
  bool hasImage;
  //? su valor sea nulo si no se asigna.
  List<String>? productionPlaces;
  String description;
  String plaqueDescription;
  List<String>? materials;
  List<String>? techniques;
  String physicalMedium;
  String sclabelline;
  String? historicalDescription;
  List<String> objectTypes;
  List<TituloAlternativo>? otherTitles;
  Fecha? datings;
  Artista? principalOrFirstMaker;
  Img? webImage;

  ObraDetalle({
    required this.objectNumber,
    required this.title,
    required this.longTitle,
    required this.hasImage,
    required this.productionPlaces,
    required this.description,
    required this.plaqueDescription,
    required this.materials,
    required this.techniques,
    required this.physicalMedium,
    required this.sclabelline,
    required this.historicalDescription,
    required this.objectTypes,
    required this.otherTitles,
    required this.datings,
    required this.principalOrFirstMaker,
    required this.webImage,
  });

  factory ObraDetalle.fromJson(Map<String, dynamic> json) => ObraDetalle(
        objectNumber: json['objectnumber'] as String,
        title: json["title"],
        longTitle: json["longtitle"],
        hasImage: json["hasimage"],
        productionPlaces: json["productionplaces"] != null &&
                json["productionplaces"].isNotEmpty
            ? List<String>.from(json["productionplaces"].map((x) => x))
            : ['No determinado'],
        description: json["description"] ?? 'Sin Descripción',
        plaqueDescription: json["plaquedescription"] ?? 'Sin Descripción',
        materials: json["materials"]?.isNotEmpty == true
            ? List<String>.from(json["materials"].map((x) => x))
            : ['Desconocidos'],
        techniques: json["techniques"] != null
            ? List<String>.from(json["techniques"].map((x) => x))
            : ['Desconocida'],
        physicalMedium: json["physicalmedium"],
        sclabelline: json["sclabelline"],
        historicalDescription:
            json["historicaldescription"] ?? 'Sin Descripción',
        objectTypes: List<String>.from(json["objectTypes"].map((x) => x)),
        otherTitles: (json['otherTitles'] as List<dynamic>?)
            ?.map((e) => TituloAlternativo.fromJson(e as Map<String, dynamic>))
            .toList(),
        datings: json["datings"] != null
            ? Fecha.fromJson(json['datings'] as Map<String, dynamic>)
            : null,
        principalOrFirstMaker: json['principalOrFirstMaker'] != null
            ? Artista.fromJson(
                json['principalOrFirstMaker'] as Map<String, dynamic>)
            : null,
        webImage: json['webImage'] != null
            ? Img.fromJson(json['webImage'] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'objectnumber': objectNumber,
        'title': title,
        'longtitle': longTitle,
        'hasimage': hasImage,
        'productionplaces': productionPlaces,
        'description': description,
        'plaquedescription': plaqueDescription,
        'materials': materials,
        'techniques': techniques,
        'physicalmedium': physicalMedium,
        'sclabelline': sclabelline,
        'historicaldescription': historicalDescription,
        'objectTypes': objectTypes,
        'otherTitles': otherTitles?.map((e) => e.toJson()).toList(),
        'datings': datings?.toJson(),
        'principalOrFirstMaker': principalOrFirstMaker?.toJson(),
        'webImage': webImage?.toJson(),
      };

  String get url => webImage?.url ?? '';
  String get name => principalOrFirstMaker?.name ?? 'Desconocido';
  String get yearEarly => datings?.yearEarly.toString() ?? 'Desconocido';
}

class Dating {
  String presentingDate;
  int sortingDate;
  int period;
  int yearEarly;
  int yearLate;

  Dating({
    required this.presentingDate,
    required this.sortingDate,
    required this.period,
    required this.yearEarly,
    required this.yearLate,
  });

  factory Dating.fromJson(Map<String, dynamic> json) => Dating(
        presentingDate: json["presentingDate"],
        sortingDate: json["sortingDate"],
        period: json["period"],
        yearEarly: json["yearEarly"],
        yearLate: json["yearLate"],
      );

  Map<String, dynamic> toJson() => {
        "presentingDate": presentingDate,
        "sortingDate": sortingDate,
        "period": period,
        "yearEarly": yearEarly,
        "yearLate": yearLate,
      };
}

class Dimension {
  String unit;
  String type;
  dynamic precision;
  dynamic dimensionPart;
  String value;

  Dimension({
    required this.unit,
    required this.type,
    required this.precision,
    required this.dimensionPart,
    required this.value,
  });

  factory Dimension.fromJson(Map<String, dynamic> json) => Dimension(
        unit: json["unit"],
        type: json["type"],
        precision: json["precision"],
        dimensionPart: json["part"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "unit": unit,
        "type": type,
        "precision": precision,
        "part": dimensionPart,
        "value": value,
      };
}

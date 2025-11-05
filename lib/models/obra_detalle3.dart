import 'dart:convert';

ObraDetalle3 obraDetalleFromJson(String str) =>
    ObraDetalle3.fromJson(json.decode(str));

String obraDetalleToJson(ObraDetalle3 data) => json.encode(data.toJson());

class ObraDetalle3 {
  //String id;
  String objectNumber;
  String title;
  String longTitle;
  dynamic copyrightHolder;
  String url;
  List<String> titles;
  String description;
  List<String> objectTypes;
  List<String> objectCollection;
  String principalMaker;
  List<String> materials;
  List<dynamic> techniques;
  List<String> productionPlaces;
  Dating dating;
  List<Dimension> dimensions;
  String physicalMedium;

  ObraDetalle3({
    //required this.id,
    required this.objectNumber,
    required this.title,
    required this.longTitle,
    required this.copyrightHolder,
    required this.url,
    required this.titles,
    required this.description,
    required this.objectTypes,
    required this.objectCollection,
    required this.principalMaker,
    required this.materials,
    required this.techniques,
    required this.productionPlaces,
    required this.dating,
    required this.dimensions,
    required this.physicalMedium,
  });

  factory ObraDetalle3.fromJson(Map<String, dynamic> json) => ObraDetalle3(
        //id: json["id"],
        objectNumber: json['objectnumber'] as String,
        title: json["title"],
        longTitle: json["longTitle"],
        copyrightHolder: json["copyrightHolder"],
        url: json["url"],
        titles: List<String>.from(json["titles"].map((x) => x)),
        description: json["description"] ?? 'without description',
        objectTypes: List<String>.from(json["objectTypes"].map((x) => x)),
        objectCollection:
            List<String>.from(json["objectCollection"].map((x) => x)),
        principalMaker: json["principalMaker"],
        materials: List<String>.from(json["materials"].map((x) => x)),
        techniques: List<dynamic>.from(json["techniques"].map((x) => x)),
        productionPlaces: json["productionPlaces"] != null
            ? List<String>.from(json["productionPlaces"].map((x) => x))
            : ['No determinado'],
        dating: Dating.fromJson(json["dating"]),
        dimensions: List<Dimension>.from(
            json["dimensions"].map((x) => Dimension.fromJson(x))),
        physicalMedium: json["physicalMedium"],
      );

  Map<String, dynamic> toJson() => {
        //"id": id,
        "objectNumber": objectNumber,
        "title": title,
        "longTitle": longTitle,
        "copyrightHolder": copyrightHolder,
        "url": url,
        "titles": List<dynamic>.from(titles.map((x) => x)),
        "description": description,
        "objectTypes": List<dynamic>.from(objectTypes.map((x) => x)),
        "objectCollection": List<dynamic>.from(objectCollection.map((x) => x)),
        "principalMaker": principalMaker,
        "materials": List<dynamic>.from(materials.map((x) => x)),
        "techniques": List<dynamic>.from(techniques.map((x) => x)),
        "productionPlaces": List<dynamic>.from(productionPlaces.map((x) => x)),
        "dating": dating.toJson(),
        "dimensions": List<dynamic>.from(dimensions.map((x) => x.toJson())),
        "physicalMedium": physicalMedium,
      };
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

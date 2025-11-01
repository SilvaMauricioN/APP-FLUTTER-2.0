import 'img.dart';
import 'fecha.dart';
import 'titulo_alternativo.dart';

class ObraDetalle {
  final String objectNumber;
  final String title;
  final String longTitle;
  final bool hasImage;
  final List<String> productionPlaces;
  final String description;
  final List<String> materials;
  final List<String> techniques;
  final String physicalMedium;
  final String scLabelLine;
  final String historicalDescription;
  final List<TituloAlternativo> otherTitles;
  final Fecha? datings;
  final Img webImage;

  ObraDetalle({
    required this.objectNumber,
    required this.title,
    required this.longTitle,
    required this.hasImage,
    required this.productionPlaces,
    required this.description,
    required this.materials,
    required this.techniques,
    required this.physicalMedium,
    required this.scLabelLine,
    required this.historicalDescription,
    required this.otherTitles,
    required this.datings,
    required this.webImage,
  });

  factory ObraDetalle.fromJson(Map<String, dynamic> json) => ObraDetalle(
        objectNumber: json['objectnumber'] ?? '',
        title: json['title'] ?? '',
        longTitle: json['longtitle'] ?? '',
        hasImage: json['hasimage'] ?? false,
        productionPlaces: List<String>.from(json['productionplaces'] ?? []),
        description: json['description'] ?? '',
        materials: List<String>.from(json['materials'] ?? []),
        techniques: List<String>.from(json['techniques'] ?? []),
        physicalMedium: json['physicalmedium'] ?? '',
        scLabelLine: json['sclabelline'] ?? '',
        historicalDescription: json['historicaldescription'] ?? '',
        otherTitles: (json['otherTitles'] as List?)
                ?.map((e) => TituloAlternativo.fromJson(e))
                .toList() ??
            [],
        datings:
            json['datings'] != null ? Fecha.fromJson(json['datings']) : null,
        webImage: json['webImage'] != null
            ? Img.fromJson(json['webImage'])
            : Img(width: 0, height: 0, url: ''),
      );

  Map<String, dynamic> toJson() => {
        'objectnumber': objectNumber,
        'title': title,
        'longtitle': longTitle,
        'hasimage': hasImage,
        'productionplaces': productionPlaces,
        'description': description,
        'materials': materials,
        'techniques': techniques,
        'physicalmedium': physicalMedium,
        'sclabelline': scLabelLine,
        'historicaldescription': historicalDescription,
        'otherTitles': otherTitles.map((e) => e.toJson()).toList(),
        'datings': datings?.toJson(),
        'webImage': webImage.toJson(),
      };
}

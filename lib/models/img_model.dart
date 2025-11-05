class Img {
  int? idWebImage;
  int? idArtObject;
  int width;
  int height;
  String url;

  Img({
    this.idWebImage,
    this.idArtObject,
    required this.width,
    required this.height,
    required this.url,
  });

  //Constructor para crear una instancia desde JSON
  factory Img.fromJson(Map<String, dynamic> json) {
    return Img(
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      url: json['url'] ?? '',
    );
  }
  //Método para convertir la instancia a JSON
  Map<String, dynamic> toJson() => {
        "IdArtObject": idArtObject,
        "width": width,
        "height": height,
        "url": url,
      };
}
//clase usada anteriormente
// class Img {
//   int width;
//   int height;
//   String url;
// 
//   Img({
//     required this.width,
//     required this.height,
//     required this.url,
//   });
// 
//   factory Img.fromJson(Map<String, dynamic> json) => Img(
//         width: json["width"],
//         height: json["height"],
//         url: json["url"],
//       );
// 
//   Map<String, dynamic> toJson() => {
//         "width": width,
//         "height": height,
//         "url": url,
//       };
// }

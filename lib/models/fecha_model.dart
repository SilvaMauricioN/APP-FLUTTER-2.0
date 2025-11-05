class Fecha {
  // int? idDating;
  // int? idArtObject;
  String presentingDate;
  int sortingDate;
  int period;
  int yearEarly;
  int yearLate;

  Fecha({
    // this.idDating,
    // this.idArtObject,
    required this.presentingDate,
    required this.sortingDate,
    required this.period,
    required this.yearEarly,
    required this.yearLate,
  });

  factory Fecha.fromJson(Map<String, dynamic> json) => Fecha(
        presentingDate: json["presentingDate"],
        sortingDate: json["sortingDate"],
        period: json["period"],
        yearEarly: json["yearEarly"],
        yearLate: json["yearLate"],
      );

  Map<String, dynamic> toJson() => {
        // "IdArtObject": idArtObject,
        "presentingDate": presentingDate,
        "sortingDate": sortingDate,
        "period": period,
        "yearEarly": yearEarly,
        "yearLate": yearLate,
      };
}

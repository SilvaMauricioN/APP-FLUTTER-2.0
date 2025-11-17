class Ocupacion {
  final int? id;
  final String name;

  Ocupacion({
    this.id,
    required this.name,
  });

  factory Ocupacion.fromJson(Map<String, dynamic> json) {
    return Ocupacion(
      id: json['idoccupation'] as int?,
      name: (json['name'] ?? '') as String,
    );
  }

  factory Ocupacion.fromJsonString(String nombreOcupacion) {
    return Ocupacion(
      id: null,
      name: nombreOcupacion,
    );
  }
  factory Ocupacion.fromString(String nombre) {
    return Ocupacion(
      id: null,
      name: nombre,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id, // La API solo usa el ID
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ocupacion && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Ocupaciones {\n'
        '  ID: $id,\n'
        '  Nombre: $name,\n'
        '}';
  }
}

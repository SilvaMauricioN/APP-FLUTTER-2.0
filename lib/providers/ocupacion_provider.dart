import '../screens/screens.dart';

class OcupacionProvider extends PeticionesBaseProvider {
  final OcupacionServicio _ocupacionServicio = OcupacionServicio();

  List<Ocupacion> _listaOcupaciones = [];
  List<Ocupacion> _ocupacionesElegidas = [];

  List<Ocupacion> get ocupaciones => _listaOcupaciones;
  List<Ocupacion> get ocupacionesElegidas => _ocupacionesElegidas;

  Future<void> getOcupaciones() async {
    if (_listaOcupaciones.isNotEmpty) return; // Ya están cargadas

    await getRequest<List<Ocupacion>>(
      reqFuncion: () async {
        final resp = await _ocupacionServicio.getOcupaciones();
        return resp.data ?? [];
      },
      enResExito: (data) {
        _listaOcupaciones = data;
        //_ocupacionesElegidas = List.from(data);
      },
    );

    if (hasError) {
      _listaOcupaciones = [];
    }
  }

  // Agregar ocupación seleccionada (sin duplicados)
  void addOcupacion(Ocupacion ocupacion) {
    if (!ocupacionesElegidas.any((o) => o.id == ocupacion.id)) {
      ocupacionesElegidas.add(ocupacion);
      notifyListeners();
    }
  }

  // Remover ocupación seleccionada
  void removeOcupacion(int? ocupacionId) {
    if (ocupacionId == null) return;

    ocupacionesElegidas.removeWhere((o) => o.id == ocupacionId);
    notifyListeners();
  }

  // Limpiar ocupaciones seleccionadas
  void clearSelectedOcupaciones() {
    ocupacionesElegidas.clear();
    notifyListeners();
  }

  // Verificar si una ocupación ya está seleccionada
  bool isOcupacionSelected(int? ocupacionId) {
    if (ocupacionId == null) return false;
    return ocupacionesElegidas.any((o) => o.id == ocupacionId);
  }

  // Obtener IDs de ocupaciones seleccionadas
  List<int> getSelectedOcupacionIds() {
    return ocupacionesElegidas.map((o) => o.id).whereType<int>().toList();
  }

  List<Ocupacion> getSelectedOcupacionesAsObjects() {
    return ocupacionesElegidas
        .map((o) => Ocupacion(id: o.id, name: o.name))
        .toList();
  }

  void setSelectedFromExisting(List<Ocupacion> ocupacionesDelArtista) {
    ocupacionesElegidas.clear();

    for (var o in ocupacionesDelArtista) {
      ocupacionesElegidas.add(o);
    }

    notifyListeners();
  }

  void setSelectedFromExistings2(List<Ocupacion> existentes) {
    _ocupacionesElegidas = existentes.map((e) => e).toList();
    notifyListeners();
  }

  // Reset completo
  void reset() {
    ocupacionesElegidas.clear();
    notifyListeners();
  }
}

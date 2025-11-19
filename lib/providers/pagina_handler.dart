import 'package:app_demo/screens/screens.dart';

class PaginaHandler extends ChangeNotifier {
  int _paginaActual = 0;
  String _artistaSeleccionado = 'Rembrandt van Rijn';
  String _numeroObjeto = 'SK-C-5';
  Artista? _artistaParaEditar;

  int get paginaActual => _paginaActual;
  String get artistaSeleccionado => _artistaSeleccionado;
  String get numeroObjeto => _numeroObjeto;
  Artista? get artistaParaEditar => _artistaParaEditar;

  // SETTERS
  set paginaActual(int value) {
    _paginaActual = value;
    notifyListeners();
  }

  set artistaSeleccionado(String nombre) {
    _artistaSeleccionado = nombre;
    notifyListeners();
  }

  set numeroObjeto(String numero) {
    _numeroObjeto = numero;
    notifyListeners();
  }

  void editarArtista(Artista? artista) {
    _artistaParaEditar = artista;
    notifyListeners();
  }

  void navegarAArtistaFormulario({Artista? artista}) {
    const int indiceFormulario = 4;

    _artistaParaEditar = artista;
    _paginaActual = indiceFormulario;
    notifyListeners();
  }

  void limpiarArtistaAEditar() {
    _artistaParaEditar = null;
    notifyListeners();
  }
}

import '../screens/screens.dart';

class ObraProvider extends PeticionesBaseProvider {
  final ObraServicio _obraServicio = ObraServicio();
  //variables
  List<Obra> _listaObras = [];
  Paginacion? _paginacion;
  int paginaActual = 1;
  final int _limite = 20;

  //getters
  List<Obra> get obras => _listaObras;
  Paginacion? get paginacion => _paginacion;

  Future<void> getColeccionObras() async {
    await getRequest(
        reqFuncion: () => _obraServicio.getColeccionObras(
            pagina: paginaActual, limite: _limite),
        enResExito: (response) {
          _listaObras = response.data ?? [];
          _paginacion = response.paginacion;
        });
  }

  void irAPaginaAnterior() {
    if (paginaActual > 1) {
      paginaActual--;
      getColeccionObras();
    }
  }

  void irAPaginaSiguiente() {
    if (_paginacion == null || _paginacion!.hayPaginaSiguiente) {
      paginaActual++;
      getColeccionObras();
    }
  }

  void irAPagina(int pagina) {
    if (pagina > 0) {
      paginaActual = pagina;
      getColeccionObras();
    }
  }

  void resetPaginacion() {
    paginaActual = 1;
    getColeccionObras();
  }
}

import '../screens/screens.dart';

class ObraProvider with ChangeNotifier {
  final ObraServicio _obraServicio = ObraServicio();
  //variables
  List<Obra> _listaObras = [];
  bool _isLoading = false;
  Object? _error;
  bool _hasError = false;
  Paginacion? _paginacion;
  int paginaActual = 1;
  final int _limite = 20;

  //getters
  List<Obra> get obras => _listaObras;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  Paginacion? get paginacion => _paginacion;
  Object? get error => _error;

  Future<void> getColeccionObras() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _obraServicio.getColeccionObras(
          pagina: paginaActual, limite: _limite);

      _listaObras = response.data ?? [];
      _paginacion = response.paginacion;
      // _isLoading = false;
      _hasError = false;
      notifyListeners();
    } on EntidadNoEncontradaException catch (e) {
      _hasError = true;
      // _isLoading = false;
      _error = e;
      // notifyListeners();
      rethrow;
    } on ApiException catch (e) {
      _listaObras = [];
      _paginacion = null;
      _error = e;
      // notifyListeners();
      rethrow;
    }
    _isLoading = false;
    notifyListeners();
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

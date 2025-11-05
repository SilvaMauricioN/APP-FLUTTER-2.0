import '../screens/screens.dart';

class ObraProvider with ChangeNotifier {
  final ObraServicio _obraServicio = ObraServicio();
  //variables
  List<Obra> _listaObras = [];
  bool _isLoading = false;
  String? _errorMsg;
  Paginacion? _paginacion;
  int paginaActual = 1;
  final int _limite = 20;

  //getters
  List<Obra> get obras => _listaObras;
  bool get isLoading => _isLoading;
  String? get errorMsg => _errorMsg;
  Paginacion? get paginacion => _paginacion;

  Future<void> fetchObras() async {
    _isLoading = true;
    _errorMsg = null;
    notifyListeners();

    try {
      final response = await _obraServicio.getColeccionObras(
          pagina: paginaActual, limite: _limite);
      if (response.isSuccess) {
        _listaObras = response.data ?? [];
        _paginacion = response.paginacion;

        if (!response.tieneResultados) {
          _errorMsg = response.message;
        }
      } else {
        _errorMsg = response.message;
        _listaObras = [];
        _paginacion = null;
      }
    } catch (e) {
      _errorMsg = 'Error: $e';
      _listaObras = [];
      _paginacion = null;
    }
    _isLoading = false;
    notifyListeners();
  }

  void irAPaginaAnterior() {
    if (paginaActual > 1) {
      paginaActual--;
      fetchObras();
    }
  }

  void irAPaginaSiguiente() {
    if (_paginacion == null || _paginacion!.hayPaginaSiguiente) {
      paginaActual++;
      fetchObras();
    }
  }

  void irAPagina(int pagina) {
    if (pagina > 0) {
      paginaActual = pagina;
      fetchObras();
    }
  }

  void resetPaginacion() {
    paginaActual = 1;
    fetchObras();
  }

  // Cargar lista de obras
  Future<List<Obra>> fetchObras3({int page = 1, int limit = 20}) async {
    _isLoading = true;
    _errorMsg = null;
    // notifyListeners();
    try {
      // _listaObras =
      //     await _obraServicio.getColeccionObras(page: page, limit: limit);

      return _listaObras;
    } catch (e) {
      _errorMsg = 'Error al cargar obras: $e';
      return [];
    }
  }
}

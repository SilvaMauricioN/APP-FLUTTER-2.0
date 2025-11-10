import '../screens/screens.dart';

class ArtistaProvider with ChangeNotifier {
  final ArtistaServicio _artistaServicio = ArtistaServicio();
  //variables
  List<Artista> _listaArtistas = [];
  List<Artista> _artistasFiltrados = [];
  bool _isLoading = false;
  String? _errorMsg;
  bool hasError = false;
  bool get isEmpty => _artistasFiltrados.isEmpty && !isLoading && !hasError;

  //getters
  List<Artista> get listaArtistas => _artistasFiltrados;
  bool get isLoading => _isLoading;
  String? get errorMsg => _errorMsg;

  Future<void> getColeccionArtistas() async {
    _isLoading = true;
    _errorMsg = null;
    notifyListeners();

    try {
      final respone = await _artistaServicio.getColeccionArtistas();
      _listaArtistas = respone.data ?? [];
      _artistasFiltrados = List.from(_listaArtistas);
      _isLoading = false;
      hasError = false;
      notifyListeners();
    } on EntidadNoEncontradaException catch (e) {
      hasError = true;
      _isLoading = false;
      _errorMsg = e.message;
      notifyListeners();
    } on ApiException catch (e) {
      hasError = true;
      _isLoading = false;
      _errorMsg = e.message;
      notifyListeners();
    }
  }

  Future<void> getObrasArtista(String nombreArtista) async {}

  void filtrarBusqueda(String query) {
    if (query.isEmpty) {
      _artistasFiltrados = List.from(_listaArtistas);
    } else {
      _artistasFiltrados = _listaArtistas
          .where((a) => a.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}

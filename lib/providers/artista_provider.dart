import '../screens/screens.dart';

class ArtistaProvider with ChangeNotifier {
  final ArtistaServicio _artistaServicio = ArtistaServicio();
  //variables
  List<Artista> _listaArtistas = [];
  List<Artista> _artistasFiltrados = [];
  bool _isLoading = false;
  String? _errorMsg;

  //getters
  List<Artista> get listaArtistas => _artistasFiltrados;
  bool get isLoading => _isLoading;
  String? get errorMsg => _errorMsg;

  Future<void> fetchArtistas() async {
    _isLoading = true;
    _errorMsg = null;
    notifyListeners();

    try {
      final response = await _artistaServicio.getArtistas();
      if (response.isSuccess) {
        _listaArtistas = response.data ?? [];
        _artistasFiltrados = List.from(_listaArtistas);

        if (!response.tieneResultados) {
          _errorMsg = response.message;
        }
      } else {
        _errorMsg = response.message;
        _listaArtistas = [];
        _artistasFiltrados = [];
      }
    } catch (e) {
      _errorMsg = 'Error: $e';
      _listaArtistas = [];
    }
    _isLoading = false;
    notifyListeners();
  }

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

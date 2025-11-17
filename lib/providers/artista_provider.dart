import 'package:app_demo/errors/recurso_existente.dart';

import '../screens/screens.dart';

class ArtistaProvider extends PeticionesBaseProvider {
  final ArtistaServicio _artistaServicio = ArtistaServicio();
  //variables
  List<Artista> _listaArtistas = [];
  List<Artista> _artistasFiltrados = [];
  List<Obra> _listaObrasDeArtista = [];
  bool get isEmpty => _artistasFiltrados.isEmpty && !isLoading && !hasError;
  // final bool _isLoading2 = false;

  //getters
  List<Artista> get listaArtistas => _artistasFiltrados;
  List<Obra> get listaObrasDeArtista => _listaObrasDeArtista;
  //@override
  //bool get isLoadings2 => _isLoading2;

  void limpiarTodo() {
    _listaObrasDeArtista = [];
    limpiarEstado(); // Del provider base
  }

  Future<void> getColeccionArtistas() async {
    await getRequest<List<Artista>>(
      reqFuncion: () async {
        final resp = await _artistaServicio.getColeccionArtistas();
        return resp.data ?? [];
      },
      enResExito: (data) {
        _listaArtistas = data;
        _artistasFiltrados = List.from(data);
      },
    );
  }

  Future<void> getObrasArtistaPorNombre(String nombreArtista) async {
    _listaObrasDeArtista = [];

    await getRequest<List<Obra>>(
      reqFuncion: () async {
        final resp =
            await _artistaServicio.getObrasArtistaPorNombre(nombreArtista);
        return resp.data ?? [];
      },
      enResExito: (data) {
        _listaObrasDeArtista = data;
      },
    );
  }

  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  Future<bool> postArtista(Artista artista) async {
    _isLoading = true;
    notifyListeners();
    try {
      final resultado = await _artistaServicio.postArtista(artista);
      _isLoading = false;
      if (resultado.isSuccess) {
        _successMessage = resultado.message;
        notifyListeners();
        return true;
      }
      _errorMessage = resultado.message;
      notifyListeners();
      return false;
    } on RecursoExistenteException catch (e) {
      _errorMessage = e.message;
      _isLoading = false;
      notifyListeners();
      return false;
    } on ApiException catch (e) {
      _errorMessage = e.message;
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = 'Error inesperado: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
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

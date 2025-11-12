import '../screens/screens.dart';

class ArtistaProvider extends PeticionesBaseProvider {
  final ArtistaServicio _artistaServicio = ArtistaServicio();
  //variables
  List<Artista> _listaArtistas = [];
  List<Artista> _artistasFiltrados = [];
  List<Obra> _listaObrasDeArtista = [];
  bool get isEmpty => _artistasFiltrados.isEmpty && !isLoading && !hasError;

  //getters
  List<Artista> get listaArtistas => _artistasFiltrados;
  List<Obra> get listaObrasDeArtista => _listaObrasDeArtista;

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
    await getRequest<List<Obra>>(
      reqFuncion: () async {
        final resp =
            await _artistaServicio.getObrasArtistaPorNombre(nombreArtista);
        return resp.data ?? [];
      },
      enResExito: (data) {
        _listaObrasDeArtista = data;
        //_artistasFiltrados = List.from(data);
      },
    );
  }

//
//
//   Future<void> getColeccionArtistas() async {
//     _isLoading = true;
//     _errorMsg = null;
//     notifyListeners();
//
//     try {
//       final respone = await _artistaServicio.getColeccionArtistas();
//       _listaArtistas = respone.data ?? [];
//       _artistasFiltrados = List.from(_listaArtistas);
//       _isLoading = false;
//       _hasError = false;
//       notifyListeners();
//     } on EntidadNoEncontradaException catch (e) {
//       _hasError = true;
//       _isLoading = false;
//       _errorMsg = e.message;
//       notifyListeners();
//     } on ApiException catch (e) {
//       _hasError = true;
//       _isLoading = false;
//       _errorMsg = e.message;
//       notifyListeners();
//     }
//   }

//   Future<void> getObrasArtistaPorNombre(String nombreArtista) async {
//     _isLoading = true;
//     _errorMsg = null;
//     notifyListeners();
//
//     try {
//       final respone =
//           await _artistaServicio.getObrasArtistaPorNombre(nombreArtista);
//       _listaObrasDeArtista = respone.data ?? [];
//       _isLoading = false;
//       _hasError = false;
//       notifyListeners();
//     } on EntidadNoEncontradaException catch (e) {
//       _hasError = true;
//       _isLoading = false;
//       _errorMsg = e.message;
//       notifyListeners();
//     } on ApiException catch (e) {
//       _hasError = true;
//       _isLoading = false;
//       _errorMsg = e.message;
//       notifyListeners();
//     }
//   }

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

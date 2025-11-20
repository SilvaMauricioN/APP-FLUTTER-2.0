import '../screens/screens.dart';

class ArtistaProvider extends PeticionesBaseProvider {
  final ArtistaServicio _artistaServicio = ArtistaServicio();

  // Variables
  List<Artista> _listaArtistas = [];
  List<Artista> _artistasFiltrados = [];
  List<Obra> _listaObrasDeArtista = [];

  // Getters
  List<Artista> get listaArtistas => _artistasFiltrados;
  List<Obra> get listaObrasDeArtista => _listaObrasDeArtista;
  bool get isEmpty => _artistasFiltrados.isEmpty && !isLoading && !hasError;

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

  Future<bool> postArtista(Artista artista) async {
    return await modifyRequest(
      reqFuncion: () => _artistaServicio.postArtista(artista),
      mensajeExito: 'Artista creado exitosamente',
    );
  }

  Future<bool> updateArtista(Artista artista) async {
    return await modifyRequest(
      reqFuncion: () => _artistaServicio.updateArtista(artista),
      mensajeExito: 'Artista actualizado exitosamente',
    );
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

  void limpiarTodo() {
    _listaArtistas = [];
    _artistasFiltrados = [];
    _listaObrasDeArtista = [];
    limpiarEstado();
  }
}

import 'package:app_demo/screens/screens.dart';

class PaginaHandler extends ChangeNotifier {
  int _paginaActual = 0;
  String _artistaSeleccionado = 'Rembrandt van Rijn';
  String _numeroObjeto = 'SK-C-5';
  Artista _artistaSeleccionado2 = Artista(
      idPrincipalMaker: 1,
      name: "Rembrandt van Rijn",
      placeOfBirth: "Leiden",
      dateOfBirth: "1606-07-15",
      dateOfDeath: "1669-10-08",
      placeOfDeath: "Ámsterdam",
      nationality: "Holandés del Norte",
      occupations: ["dibujante", "grabador", "pintor"]);

  int get paginaActual => _paginaActual;
  String get artistaSeleccionado => _artistaSeleccionado;
  String get numeroObjeto => _numeroObjeto;
  Artista get artistaSeleccionado2 => _artistaSeleccionado2;

  set paginaActual(int value) {
    _paginaActual = value;
    notifyListeners();
  }

  set artistaSeleccionado(String nombre) {
    _artistaSeleccionado = nombre;
    notifyListeners();
  }

  set numeroObjeto(String numeroObjeto) {
    _numeroObjeto = numeroObjeto;
    notifyListeners();
  }

  set artistaSeleccionado2(Artista artista) {
    _artistaSeleccionado2 = artista;
    notifyListeners();
  }
}

import 'package:app_demo/screens/screens.dart';

class ObraDetalleProvider extends PeticionesBaseProvider {
  final ObraDetalleServicio _obraDetalleServicio = ObraDetalleServicio();

  List<ObraDetalle> _listaObraDetalle = [];
  List<ObraDetalle> get listaObraDetalle => _listaObraDetalle;

  Future<void> getObraDetalle(String objectNumber) async {
    await getRequest<List<ObraDetalle>>(
      reqFuncion: () async {
        final resp =
            await _obraDetalleServicio.getObraDetallePorId(objectNumber);
        return resp.data ?? [];
      },
      enResExito: (data) {
        _listaObraDetalle = data;
      },
    );
  }

//   Future<void> getObraDetallePorId(String objectNumber) async {
//     _isLoading = true;
//     _hasError = false;
//     _errorMsg = null;
//     _listaObraDetalle = [];
//     notifyListeners();
//     try {
//       final response =
//           await _obraDetalleServicio.getObraDetallePorId(objectNumber);
//
//       _listaObraDetalle = response.data ?? [];
//
//       if (_listaObraDetalle.isEmpty) {
//         throw EntidadNoEncontradaException(
//             'No se encontraron detalles de obras para el ID.', 'Lista vacía');
//       }
//       _hasError = false;
//       _isLoading = false;
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
}

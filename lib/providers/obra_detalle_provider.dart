import 'package:app_demo/screens/screens.dart';

class ObraDetalleProvider with ChangeNotifier {
  final ObraDetalleServicio _obraServicioDetalle = ObraDetalleServicio();

  Future<ObraDetalle> getObraPorId(String id) async {
    try {
      return await _obraServicioDetalle.getObraDetallePorId(id);
    } on EntidadNoEncontradaException {
      rethrow;
    } on ApiException {
      rethrow;
    } catch (error) {
      throw Exception('Error inesperado: ${error.toString()}');
    }
  }
}

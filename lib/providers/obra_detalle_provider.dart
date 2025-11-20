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
}

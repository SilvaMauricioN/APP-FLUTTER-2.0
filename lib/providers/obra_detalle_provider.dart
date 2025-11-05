import 'package:flutter/material.dart';
import '../services/obra_detalle_servicio.dart';
import '../models/obra_detalle_model.dart';

class ObraDetalleProvider with ChangeNotifier {
  final ObraDetalleServicio _obraServicioDetalle = ObraDetalleServicio();
//
//   String numeroObjeto = '';
//   ObraDetalle? obraDetalle;
//   bool isLoading = false;
//   String? error;
//
//   void setNumeroObjeto(String id) {
//     numeroObjeto = id;
//     notifyListeners();
//   }

  Future<ObraDetalle> getObraPorId(String idObjeto) async {
    try {
      final obra = await _obraServicioDetalle.getObraDetallePorId(idObjeto);
      return obra;
    } catch (e) {
      throw Exception('Error al obtener la obra: $e');
    }
  }
}

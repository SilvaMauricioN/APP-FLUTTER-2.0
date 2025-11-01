// import 'package:app_demo/models/fecha.dart';
// import 'package:app_demo/models/titulo_alternativo.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import '../models/obra.dart';
// import '../models/obra_detalle.dart';
// import '../config/api_config.dart';
// import '../models/img.dart';
import '../services/obra_servicio.dart';

class ObraProvider with ChangeNotifier {
  final ObraServicio _obraServicio = ObraServicio();

  List<Obra> _listaObras = [];
  bool _isLoading = false;
  String? _errorMsg;

  List<Obra> get obras => _listaObras;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMsg;

  /// Cargar lista de obras
  Future<List<Obra>> fetchObras({int page = 1, int limit = 20}) async {
    _isLoading = true;
    _errorMsg = null;
    // notifyListeners();
    try {
      _listaObras =
          await _obraServicio.getColeccionObras(page: page, limit: limit);

      return _listaObras;
    } catch (e) {
      _errorMsg = 'Error al cargar obras: $e';
      return [];
    }
  }
}

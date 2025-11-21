import '../screens/screens.dart';

abstract class PeticionesBaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _hasError = false;
  String? _errorMsg;
  String? _successMsg;
  Object? _error;

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String? get errorMessage => _errorMsg;
  String? get successMsg => _successMsg;
  Object? get error => _error;

  void limpiarEstado() {
    _isLoading = false;
    _hasError = false;
    _errorMsg = null;
    _successMsg = null;
    _error = null;
    notifyListeners();
  }

  /// Para peticiones GET
  Future<void> getRequest<T>({
    required Future<T> Function() reqFuncion,
    required void Function(T data) enResExito,
  }) async {
    _isLoading = true;
    _hasError = false;
    _errorMsg = null;
    notifyListeners();

    try {
      final data = await reqFuncion();
      enResExito(data);
      _hasError = false;
    } on EntidadNoEncontradaException catch (e) {
      _hasError = true;
      _errorMsg = e.message;
      _error = e;
      rethrow;
    } on ApiException catch (e) {
      _hasError = true;
      _errorMsg = e.message;
      _error = e;
      rethrow;
    } catch (e) {
      _hasError = true;
      _errorMsg = 'Error inesperado: ${e.toString()}';
      _error = e;
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Para peticiones POST/PUT/DELETE
  Future<bool> modifyRequest({
    required Future<ApiResponse> Function() reqFuncion,
    String? mensajeExito,
  }) async {
    _isLoading = true;
    _hasError = false;
    _errorMsg = null;
    _successMsg = null;
    notifyListeners();

    try {
      final resultado = await reqFuncion();

      if (resultado.isSuccess) {
        _successMsg = mensajeExito ?? resultado.message;
        _hasError = false;
        return true;
      }

      _errorMsg = resultado.message;
      _hasError = true;
      return false;
    } on RecursoExistenteException catch (e) {
      _hasError = true;
      _errorMsg = e.message;
      _error = e;
      return false;
    } on RecursoNoEncontrado catch (e) {
      _hasError = true;
      _errorMsg = e.message;
      _error = e;
      return false;
    } on ApiException catch (e) {
      _hasError = true;
      _errorMsg = e.message;
      _error = e;
      return false;
    } catch (e) {
      _hasError = true;
      _errorMsg = 'Error inesperado: ${e.toString()}';
      _error = e;
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Limpiar solo mensajes
  void limpiarMensajes() {
    _errorMsg = null;
    _successMsg = null;
    notifyListeners();
  }
}

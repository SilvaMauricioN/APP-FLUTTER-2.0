import '../screens/screens.dart';

abstract class PeticionesBaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _hasError = false;
  String? _errorMsg;
  Object? _error;

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String? get errorMsg => _errorMsg;
  Object? get error => _error;

  Future<void> getRequest<T>({
    required Future<T> Function() reqFuncion,
    required void Function(T data) enResExito,
  }) async {
    _isLoading = true;
    _errorMsg = null;
    notifyListeners();

    try {
      final data = await reqFuncion();
      enResExito(data);
      _isLoading = false;
      _hasError = false;
      notifyListeners();
    } on EntidadNoEncontradaException catch (e) {
      _hasError = true;
      _isLoading = false;
      _errorMsg = e.message;
      _error = e;
      notifyListeners();
      rethrow;
    } on ApiException catch (e) {
      _hasError = true;
      _isLoading = false;
      _errorMsg = e.message;
      _error = e;
      notifyListeners();
      rethrow;
    }
  }
}

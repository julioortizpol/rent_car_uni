import 'dart:html';

class WebLocalStorage {
  final Storage _localStorage = window.localStorage;

  Future save(String data, String label) async {
    _localStorage[label] = data;
  }

  Future<String> get(String label) async => _localStorage[label];

  Future delete(String label) async {
    _localStorage.remove(label);
  }
}

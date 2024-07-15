class ApiConfig {
  static String? _url;

  static String get url => _url ?? '';

  static set url(String url) {
    _url = url;
  }
}

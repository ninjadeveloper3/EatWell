/// Enum to define Application Environment instance
enum Environment { DEV, STAGING, PROD }

class EnvironmentConstants {
  // baseUrl for images for live
  static String baseUrl = 'http://192.168.1.47:8080/eatwell';

  static String? _config;

  /// method to set environment
  static String setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = "http://192.168.1.47:8080/eatwell_guest";
        break;
      case Environment.STAGING:
        _config = "http://192.168.1.47:8080/eatwell";
        break;
      case Environment.PROD:
        _config = "http://192.168.1.47:8080/eatwell";
        break;
    }
    return _config!;
  }
}

enum Environment { dev, prod }

class EnvironmentConfig {
  static const String _env = String.fromEnvironment('ENV', defaultValue: 'dev');

  static const String _apiBaseUrl = String.fromEnvironment('API_BASE_URL');

  static const String _authExpiration = String.fromEnvironment(
    'AUTH_EXPIRATION',
    defaultValue: '0.1',
  );

  static const String _sessionExpiration = String.fromEnvironment(
    'SESSION_EXPIRATION',
    defaultValue: '30',
  );

  static Environment get currentEnvironment {
    switch (_env) {
      case 'prod':
        return Environment.prod;
      case 'dev':
      default:
        return Environment.dev;
    }
  }

  static String get apiBaseUrl {
    if (_apiBaseUrl.isNotEmpty) return _apiBaseUrl;

    // Fallback based on ENV
    switch (currentEnvironment) {
      case Environment.prod:
        return "https://api.aveimpulsos.com/";
      case Environment.dev:
        return "http://localhost:8000/";
    }
  }

  static double get authExpiration => double.parse(_authExpiration);

  static int get sessionExpiration => int.parse(_sessionExpiration);
}

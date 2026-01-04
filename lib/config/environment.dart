enum Environment { development, staging, production }

abstract final class AppEnvironment {
  static const Environment current = Environment.development;

  static bool get isDevelopment => current == Environment.development;
  static bool get isStaging => current == Environment.staging;
  static bool get isProduction => current == Environment.production;

  static String get baseUrl {
    switch (current) {
      case Environment.development:
        return 'http://localhost:3000/api';
      case Environment.staging:
        return 'https://staging-api.glowstate.app';
      case Environment.production:
        return 'https://api.glowstate.app';
    }
  }
}

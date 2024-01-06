abstract class EnvVars {
  static String get env => const String.fromEnvironment('ENV');
  static String get baseURL => const String.fromEnvironment('BASE_URL');
  static String get oneSignalKey => const String.fromEnvironment('ONESIGNAL_KEY');
  static bool get crashlyticsEnabled => const bool.fromEnvironment('CRASHLYTICS_ENABLED');
  static bool get previewEnabled => const bool.fromEnvironment('PREVIEW_ENABLED');
}

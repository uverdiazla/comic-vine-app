/// Interface for application configuration settings.
/// This allows for flexibility in changing the source of configuration (e.g., from environment variables, API, etc.).
abstract class IAppConfig {
  /// Base URL for the Comic Vine API.
  String get baseUrl;

  /// API key for authenticating requests to the Comic Vine API.
  String get apiKey;
}
import 'package:comic_vine_app/core/contracts/i_app_config.dart';

/// Concrete implementation of the IAppConfig interface.
/// This class provides the actual values for the configuration settings.
class AppConfig implements IAppConfig {
  @override
  String get baseUrl => 'https://comicvine.gamespot.com/api';

  @override
  String get apiKey => '4e643cd8133a54359388cae00f9695850c6cc2ac'; // Replace with your actual API key
}
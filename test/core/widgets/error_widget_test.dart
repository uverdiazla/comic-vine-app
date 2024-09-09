import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:comic_vine_app/core/contracts/i_theme_config.dart';
import 'package:comic_vine_app/core/widgets/error_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import the generated localization file

// Simple concrete implementation of IThemeConfig for testing purposes
class TestThemeConfig implements IThemeConfig {
  @override
  Color getConfigErrorColor() {
    return Colors.red;
  }

  @override
  Color getDefaultTextColor() {
    return Colors.black;
  }


  @override
  Color getAccentColor() {
    throw UnimplementedError();
  }

  @override
  Color getAppBarColor() {
    throw UnimplementedError();
  }

  @override
  Color getPrimaryColor() {
    throw UnimplementedError();
  }

  @override
  Color getSecondaryBackgroundColor() {
    throw UnimplementedError();
  }

  @override
  Color getSubtitleSectionColor() {
    throw UnimplementedError();
  }

  @override
  ThemeData getTheme() {
    throw UnimplementedError();
  }

  @override
  Color getTitleSectionColor() {
    throw UnimplementedError();
  }
}

void main() {
  final getIt = GetIt.instance;

  setUp(() {
    // Register the concrete test implementation in GetIt
    getIt.registerSingleton<IThemeConfig>(TestThemeConfig());
  });

  tearDown(() {
    // Clear the GetIt instance after each test
    getIt.reset();
  });

  testWidgets('ErrorWidget shows the correct error message', (WidgetTester tester) async {
    const errorMessage = 'An error occurred';

    // Build the widget with localization support
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate, // Add your localization delegate here
        ],
        supportedLocales: [Locale('en', '')], // Set your supported locales
        home: Scaffold(body: CustomErrorWidget(errorMessage: errorMessage)),
      ),
    );

    // Verify that the error message is displayed
    expect(find.text(errorMessage), findsOneWidget);
  });
}

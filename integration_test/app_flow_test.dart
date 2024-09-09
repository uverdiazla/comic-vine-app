import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:comic_vine_app/main.dart' as app;
import 'package:comic_vine_app/core/widgets/comic_tile.dart'; // Asegúrate de tener este import correcto
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Flow Test', () {
    testWidgets('App loads and displays comic list', (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Wait for "Latest Issues" to appear
      await waitForWidget(
        tester,
        find.text(AppLocalizations.of(tester.element(find.byType(Scaffold)))!.latest_issues),
      );

      // Ensure there is at least one ComicTile in the list
      var comicTileFinder = find.byType(ComicTile);
      await waitForWidget(tester, comicTileFinder);

      // Tap the first comic tile
      await tester.tap(comicTileFinder.first);
      await tester.pumpAndSettle();

      // Ensure we are now on the comic detail page
      var comicDetailFinder = find.text('Creators');
      await waitForWidget(tester, comicDetailFinder);

      // Simulate going back to the comic list using `pop()`
      tester.state<NavigatorState>(find.byType(Navigator)).pop();
      await tester.pumpAndSettle();

      // Ensure we are back on the comic list page
      await waitForWidget(
        tester,
        find.text(AppLocalizations.of(tester.element(find.byType(Scaffold)))!.latest_issues),
      );

      // Ensure there is at least one ComicTile in the list
      var comicTileFinderStorage = find.byType(ComicTile);
      await waitForWidget(tester, comicTileFinderStorage);

      // Tap the first comic tile
      await tester.tap(comicTileFinderStorage.first);
      await tester.pumpAndSettle();

      // Ensure we are now on the comic detail page
      var comicDetailFinderStorage = find.text('Creators');
      await waitForWidget(tester, comicDetailFinderStorage);

      // Simulate pull down to refresh (force reload)
      await tester.drag(
        find.byType(RefreshIndicator),
        const Offset(0, 300), // Dragging down to trigger refresh
      );
      await tester.pumpAndSettle(const Duration(seconds: 2)); // Wait for the refresh to complete

      // Ensure we are still on the comic detail page after refresh
      await waitForWidget(tester, comicDetailFinder);

      // Simulate going back to the comic list using `pop()`
      tester.state<NavigatorState>(find.byType(Navigator)).pop();
      await tester.pumpAndSettle();

      // Ensure we are back on the comic list page
      await waitForWidget(
        tester,
        find.text(AppLocalizations.of(tester.element(find.byType(Scaffold)))!.latest_issues),
      );

      // Ensure there is at least one ComicTile in the list
      var comicTileFinderStorageBack = find.byType(ComicTile);
      await waitForWidget(tester, comicTileFinderStorageBack);

      // Scroll down to load more items
      await tester.drag(
        find.byType(Scrollable).first,
        const Offset(0, -1000), // Scroll up (downwards on screen)
      );
      await tester.pumpAndSettle(const Duration(seconds: 2)); // Wait for new items to load

      // Ensure more items were loaded (if applicable)
      var additionalComicTileFinder = find.byType(ComicTile);
      expect(additionalComicTileFinder.evaluate().length, greaterThan(1));

    });
  });
}
/// Helper function to wait for a widget to appear on screen.
/// If the widget is not found within the timeout, the test will fail.
Future<void> waitForWidget(WidgetTester tester, Finder finder,
    {Duration timeout = const Duration(seconds: 10)}) async {
  final endTime = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(endTime)) {
    await tester.pump();
    if (finder.evaluate().isNotEmpty) {
      return; // Widget found, return and continue the test
    }
    await Future.delayed(const Duration(milliseconds: 100)); // Small delay before next check
  }
  // If the widget is not found within the timeout, throw an error
  fail('Widget not found: $finder after waiting for ${timeout.inSeconds} seconds');
}

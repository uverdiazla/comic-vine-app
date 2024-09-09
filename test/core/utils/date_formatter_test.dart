import 'package:comic_vine_app/core/utils/date_formatter.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('DateFormatter Tests', () {
    final dateFormatter = DateFormatter();
    final testDate = DateTime(2024, 8, 7); // August 7, 2024

    test('formats date correctly with default format', () {
      final formattedDate = dateFormatter.formatDate(testDate);
      expect(formattedDate, '2024-08-07');
    });

    test('formats date correctly with full month name', () {
      final formattedDate = dateFormatter.formatDateWithMonthName(testDate);
      expect(formattedDate, 'August 07, 2024');
    });
  });
}

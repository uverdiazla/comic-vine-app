import 'package:comic_vine_app/core/contracts/i_text_formatter.dart';

/// Implementation of [ITextFormatter] to clean HTML tags from strings.
/// This uses a regular expression to remove all HTML tags.
class HtmlTextFormatter implements ITextFormatter {
  @override
  String format(String input) {
    // Remove all HTML tags using a regular expression.
    return input.replaceAll(RegExp(r'<[^>]*>'), '');
  }
}

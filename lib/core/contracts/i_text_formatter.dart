/// Interface that defines the contract for text formatting.
/// This can be used for different types of text processing,
/// such as cleaning HTML or other formats.
abstract class ITextFormatter {
  /// Takes a string input and returns a formatted output.
  String format(String input);
}

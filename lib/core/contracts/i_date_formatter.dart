/// Interface for date formatter
abstract class IDateFormatter {
  String formatDate(DateTime date);  // Default format (yyyy-MM-dd)
  String formatDateWithMonthName(DateTime date);  // New format (MMMM dd, yyyy)
}

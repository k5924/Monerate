/// This extension extends the String types capabilities by allowing us to add methods to the String type
extension StringExtension on String {
  /// This method capitalizes the first letter of a string
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

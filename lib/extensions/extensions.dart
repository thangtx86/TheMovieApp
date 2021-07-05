extension StringExtension on String {
  String getYear() {
    int firstIndex = this.indexOf("-");
    String yearOfString = this.substring(0, firstIndex);
    return yearOfString.trim();
  }
}

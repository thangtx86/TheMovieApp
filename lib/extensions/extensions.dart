extension StringExtension on String {
  String getYear() {
    int firstIndex = this.indexOf("-");
    String yearOfString = this.substring(0, firstIndex);
    return yearOfString.trim();
  }
}

extension IntExtension on int {
  String convertIntToTimes() {
    Duration d = Duration(minutes: this);
    var seconds = d.inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];
    if (days != 0) {
      tokens.add('${days}d');
    }
    if (tokens.isNotEmpty || hours != 0) {
      tokens.add('${hours}h');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('${minutes}min');
    }
    if (tokens.isEmpty || seconds != 0) {
      tokens.add('${seconds}s');
    }

    return tokens.join(' ');
  }
}

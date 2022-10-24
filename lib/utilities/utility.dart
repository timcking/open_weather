import 'package:intl/intl.dart';

int calcHour(epochDate) {
  DateTime localDate =
      new DateTime.fromMillisecondsSinceEpoch(epochDate * 1000);
  var format = new DateFormat('H');
  var hour = format.format(localDate);

  return int.parse(hour);
}

String convertTime(int theDate) {
  final DateTime date0 = DateTime.fromMillisecondsSinceEpoch(theDate * 1000);
  return DateFormat("h:mm a").format(date0);
}

String convertToTitleCase(String text) {
  if (text == null) {
    return '';
  }

  if (text.length <= 1) {
    return text.toUpperCase();
  }

  // Split string into multiple words
  final List<String> words = text.split(' ');

  // Capitalize first letter of each words
  final capitalizedWords = words.map((word) {
    if (word.trim().isNotEmpty) {
      final String firstLetter = word.trim().substring(0, 1).toUpperCase();
      final String remainingLetters = word.trim().substring(1);

      return '$firstLetter$remainingLetters';
    }
    return '';
  });

  // Join/Merge all words back to one String
  return capitalizedWords.join(' ');
}

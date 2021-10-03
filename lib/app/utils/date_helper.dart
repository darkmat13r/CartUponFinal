import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:logger/logger.dart';

class DateHelper {
  static String formatExpiry(DateTime startDate, String serverDate) {
    var date = parseServerDateTime(serverDate);
    var timeRemaining = date.difference(startDate);
    return formatElapsedTime(timeRemaining);
  }
  static String format(DateTime startDate, DateTime serverDate) {
    var timeRemaining = serverDate.difference(startDate);
    return formatElapsedTime(timeRemaining);
  }
  static DateTime parseServerDateTime(String serverDate) {
    return DateTime.parse(serverDate).toLocal();
  }
  static isValidTime(DateTime dateFrom, DateTime dateTo){
    var isValid = false;
    if (dateFrom == null && dateTo == null) {
      return false;
    }
    var validFrom = dateFrom;
    var validTo = dateTo;
    if (validFrom != null &&
        validTo != null) {
      isValid = validFrom.toUtc().isBefore(validTo.toUtc()) && validTo.toUtc().isAfter(DateTime.now());
    }
    return isValid;
  }

  static String formatElapsedTime(Duration d) {
    var seconds = d.inSeconds;
    final days = seconds~/Duration.secondsPerDay;
    seconds -= days*Duration.secondsPerDay;
    final hours = seconds~/Duration.secondsPerHour;
    seconds -= hours*Duration.secondsPerHour;
    final minutes = seconds~/Duration.secondsPerMinute;
    seconds -= minutes*Duration.secondsPerMinute;
    final List<String> tokens = [];
    if (days != 0) {
      tokens.add('${twoDigit(days)}d');
    }
    if (tokens.isNotEmpty || hours != 0){
      tokens.add('${twoDigit(hours)}h');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('${twoDigit(minutes)}m');
    }
    tokens.add('${twoDigit(seconds)}s');

    return tokens.join(':');
  }

  static String twoDigit(int number) {
    if (number < 10) {
      return "0$number";
    }
    return "$number";
  }

  static formatServerDate(String createdAt) {
    return DateFormat.yMMMd().add_Hm().format(DateHelper.parseServerDateTime(createdAt));
  }
  static formatServerDateOnly(String createdAt) {
    return DateFormat.yMMMd().format(DateHelper.parseServerDateTime(createdAt));
  }
}

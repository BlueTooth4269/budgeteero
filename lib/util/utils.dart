class Utils {
  static DateTime dateOnlyUTC(DateTime date) {
    return DateTime.utc(date.year, date.month, date.day);
  }
}
/// Calendar dates (a day with no time of day).
///
/// A calendar date is represented as UTC midnight of that day, e.g.
/// `2026-11-14T00:00:00Z`. Storing it this way keeps the same day whatever
/// the device time zone is, and lets two dates be compared with `==`.
library;

/// The calendar day of [moment], read in the time zone [moment] carries.
///
/// For a local `DateTime.now()` this is the user's current day.
DateTime calendarDate(DateTime moment) =>
    DateTime.utc(moment.year, moment.month, moment.day);

/// Whole years from [from] to [to], e.g. an age. Both are read as calendar
/// dates; a birthday that has not arrived yet in [to]'s year does not count.
int yearsBetween(DateTime from, DateTime to) {
  var years = to.year - from.year;
  final beforeAnniversary =
      to.month < from.month || (to.month == from.month && to.day < from.day);
  if (beforeAnniversary) years--;
  return years;
}

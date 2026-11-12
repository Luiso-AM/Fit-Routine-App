/// Locale for `intl` number and date formatting.
///
/// The app targets `es_PE`, but `intl` ships no data for it and would fall
/// back to `es` (decimal comma). `es_419` (Latin American Spanish) matches
/// Peru's conventions: decimal point and comma grouping, e.g. `12,450.5`.
const String kIntlLocale = 'es_419';

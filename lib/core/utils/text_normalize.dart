const Map<String, String> _accents = {
  'á': 'a',
  'à': 'a',
  'ä': 'a',
  'â': 'a',
  'é': 'e',
  'è': 'e',
  'ë': 'e',
  'ê': 'e',
  'í': 'i',
  'ì': 'i',
  'ï': 'i',
  'î': 'i',
  'ó': 'o',
  'ò': 'o',
  'ö': 'o',
  'ô': 'o',
  'ú': 'u',
  'ù': 'u',
  'ü': 'u',
  'û': 'u',
  'ñ': 'n',
};

final RegExp _whitespace = RegExp(r'\s+');

/// Normalizes text for search and duplicate checks: lowercase, no accents,
/// trimmed and with single spaces. `"  Curl de  Bíceps "` -> `"curl de biceps"`.
String normalizeText(String text) {
  final lower = text.trim().toLowerCase().replaceAll(_whitespace, ' ');
  final buffer = StringBuffer();
  for (final char in lower.split('')) {
    buffer.write(_accents[char] ?? char);
  }
  return buffer.toString();
}

import 'package:app_entrenamiento/core/utils/text_normalize.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final cases = <String, String>{
    'Curl de Bíceps': 'curl de biceps',
    '  Press   Militar  ': 'press militar',
    'EXTENSIÓN DE CUÁDRICEPS': 'extension de cuadriceps',
    'Pingüino': 'pinguino',
    'Año': 'ano',
    '': '',
  };

  for (final MapEntry(key: input, value: expected) in cases.entries) {
    test('given "$input", when normalized, then it is "$expected"', () {
      expect(normalizeText(input), expected);
    });
  }
}

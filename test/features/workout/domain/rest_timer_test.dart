import 'package:app_entrenamiento/features/workout/domain/rest_timer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime.utc(2026, 11, 16, 10);

  group('endAfter', () {
    test('given a rest of 90 s, when started now, '
        'then it ends 90 s later', () {
      expect(RestTimer.endAfter(90, now), now.add(const Duration(seconds: 90)));
    });

    test('given no rest or a rest of 0 s, then there is no end', () {
      expect(RestTimer.endAfter(null, now), isNull);
      expect(RestTimer.endAfter(0, now), isNull);
      expect(RestTimer.endAfter(-5, now), isNull);
    });
  });

  group('adjust', () {
    final endsAt = now.add(const Duration(seconds: 60));

    test('given a running rest, when adding 15 s, then it ends 15 s later', () {
      expect(
        RestTimer.adjust(endsAt, RestTimer.adjustStep, now),
        now.add(const Duration(seconds: 75)),
      );
    });

    test('given a running rest, when removing 15 s, '
        'then it ends 15 s earlier', () {
      expect(
        RestTimer.adjust(endsAt, -RestTimer.adjustStep, now),
        now.add(const Duration(seconds: 45)),
      );
    });

    test('given 10 s left, when removing 15 s, then the rest is over', () {
      final soon = now.add(const Duration(seconds: 10));
      expect(RestTimer.adjust(soon, -RestTimer.adjustStep, now), isNull);
    });

    test('given 15 s left, when removing 15 s, then the rest is over', () {
      final soon = now.add(const Duration(seconds: 15));
      expect(RestTimer.adjust(soon, -RestTimer.adjustStep, now), isNull);
    });
  });

  group('remaining', () {
    test('given an end in the future, then it is the time until then', () {
      expect(
        RestTimer.remaining(now.add(const Duration(seconds: 42)), now),
        const Duration(seconds: 42),
      );
    });

    test('given an end in the past, then it is zero', () {
      expect(
        RestTimer.remaining(now.subtract(const Duration(seconds: 5)), now),
        Duration.zero,
      );
    });
  });

  group('isRunning', () {
    test('given an end in the future, then it is running', () {
      expect(
        RestTimer.isRunning(now.add(const Duration(seconds: 1)), now),
        isTrue,
      );
    });

    test('given no end, an end now or in the past, then it is not running', () {
      expect(RestTimer.isRunning(null, now), isFalse);
      expect(RestTimer.isRunning(now, now), isFalse);
      expect(
        RestTimer.isRunning(now.subtract(const Duration(seconds: 1)), now),
        isFalse,
      );
    });
  });
}

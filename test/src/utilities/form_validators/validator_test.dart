import 'package:flutter_test/flutter_test.dart';
import 'package:monerate/src/utilities/export.dart';

void main() {
  group('Validator:', () {
    test('If value is empty, return false', () {
      final result = Validator().presenceDetection('');
      expect(result, false);
    });

    test('If value is not empty, return true', () {
      final result = Validator().presenceDetection('a');
      expect(result, true);
    });
  });
}

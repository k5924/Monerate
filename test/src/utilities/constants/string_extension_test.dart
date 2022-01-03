import 'package:flutter_test/flutter_test.dart';
import 'package:monerate/src/utilities/export.dart';

void main() {
  group('String Extension:', () {
    String words;
    test('Calling capitalize() capitalizes first letter of string', () {
      words = 'hello';
      final result = words.capitalize();
      expect(result, 'Hello');
    });

    test('Calling capitalize() capitalizes only the first letter of the first word in the string', () {
      words = 'hello world';
      final result = words.capitalize();
      expect(result, 'Hello world');
    });
  });
}

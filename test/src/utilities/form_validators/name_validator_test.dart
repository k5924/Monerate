import 'package:flutter_test/flutter_test.dart';
import 'package:monerate/src/utilities/export.dart';

void main() {
  group('Name Validator:', () {
    test('Empty name returns error', () {
      final result = NameValidator().validateName('');
      expect(result, "This field cant be left empty");
    });

    test('Non empty name doesnt return error', () {
      final result = NameValidator().validateName('a');
      expect(result, null);
    });

    test('Number in name returns error', () {
      final result = NameValidator().validateName('1');
      expect(result, 'Please enter a valid name');
    });
  });
}

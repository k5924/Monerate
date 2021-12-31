import 'package:flutter_test/flutter_test.dart';
import 'package:monerate/src/utilities/export.dart';

void main() {
  group('Name Validator:', () {
    test('Empty name returns error', () {
      final result = NameValidator().validateName('');
      expect(result, "This field cant be left empty");
    });

    test('Non empty name doesnt returns error', () {
      final result = NameValidator().validateName('a');
      expect(result, null);
    });

    
    
  });
}
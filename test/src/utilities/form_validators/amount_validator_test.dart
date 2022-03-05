import 'package:flutter_test/flutter_test.dart';
import 'package:monerate/src/utilities/export.dart';

void main() {
  group('Amount Validator: ', () {
    test('Empty Amount returns error', () {
      final result = AmountValidator().validateAmount('');
      expect(
        result,
        "An amount is required before adding the investment to your portfolio",
      );
    });

    test('An invalid amount returns an error', () {
      final result = AmountValidator().validateAmount('0.1.0');
      expect(result, "Enter a valid amount");
    });

    test('A valid amount doesnt give an error', () {
      final result = AmountValidator().validateAmount('1.1');
      expect(result, null);
    });
  });
}

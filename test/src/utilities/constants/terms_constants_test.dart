import 'package:flutter_test/flutter_test.dart';
import 'package:monerate/src/utilities/constants/export.dart';

void main() {
  group('Terms Constants:', () {
    test('Check that terms match', () {
      expect(
        kTermsAndConditions,
        "By using our app, you agree to share personal information such as your email address, name, bank details and any other financial information you choose to share when using the app.",
      );
    });
  });
}

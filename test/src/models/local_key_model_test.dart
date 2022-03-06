import 'package:flutter_test/flutter_test.dart';
import 'package:monerate/src/models/export.dart';

void main() {
  group('Local Key Model:', () {
    final LocalKeyModel localKeyModel = LocalKeyModel(
      provider: 'exchange',
      keys: [
        'key1',
        'key2',
      ],
    );

    test(
      'Retrieving provider from localKeyModel instance returns correctly',
      () {
        expect(
          localKeyModel.provider,
          'exchange',
        );
      },
    );

    test(
      'Retrieving keys from localKeyModel instance returns correctly',
      () {
        expect(
          localKeyModel.keys,
          ['key1', 'key2'],
        );
      },
    );
  });
}

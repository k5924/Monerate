import 'package:flutter_test/flutter_test.dart';
import 'package:monerate/src/models/export.dart';

void main() {
  group('Balance Model:', () {
    final BalanceModel balanceModel = BalanceModel(
      amount: '1',
      name: 'APPLE',
      price: '100',
      symbol: 'AAPL',
      type: 'Stock',
      userID: 'SHJKDHVFLKAJSYFJNASDLCUSAHDFL',
    );

    test(
        'Populated FinancialAdvisorModel.toMap() returns supplied value for each field',
        () {
      expect(
        balanceModel.toMap(),
        {
          'amount': '1',
          'name': 'APPLE',
          'price': '100',
          'symbol': 'AAPL',
          'type': 'Stock',
          'userID': 'SHJKDHVFLKAJSYFJNASDLCUSAHDFL',
        },
      );
    });
  });
}

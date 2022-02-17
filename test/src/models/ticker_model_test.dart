import 'package:flutter_test/flutter_test.dart';
import 'package:monerate/src/models/export.dart';

void main() {
  group('Ticker Model:', () {
    final TickerModel tickerModel = TickerModel(
      exchange: 'LSE',
      longName: 'Tesla',
      symbol: 'TSLA',
    );
    test('Calling exchange on ticker object returns associated exchange', () {
      expect(
        tickerModel.exchange,
        'LSE',
      );
    });

    test('Calling longName on ticker object returns associated longName', () {
      expect(
        tickerModel.longName,
        'Tesla',
      );
    });

    test('Calling symbol on ticker object returns associated ticker symbol',
        () {
      expect(
        tickerModel.symbol,
        'TSLA',
      );
    });
  });
}

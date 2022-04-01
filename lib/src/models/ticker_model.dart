/// This class outlines the structure for a ticker model instance
class TickerModel {
  /// This variable will store the long name of an investment
  final String longName;

  /// This variable will store the symbol associated with an investment
  final String symbol;

  /// This variable will store the exchange the investment is available to trade on
  final String exchange;

  /// This is the constructor for the ticker model class which requires that a long name, symbol and exchange name are supplied on creation
  TickerModel({
    required this.longName,
    required this.symbol,
    required this.exchange,
  });
}

/// This class structures the balances data stored in the balances collection
class BalanceModel {
  /// This variable stores the amount of each investment
  String amount;

  /// This variable stores the name of the investment
  String name;

  /// This variable stores the price of the investment
  String price;

  /// This variable stores the symbol associated with each investment
  String symbol;

  /// This variable stores the type for each investment
  String type;

  /// This variable stores the user id of the user associated with each investment
  String userID;

  /// This constructor requires all fields be populated on class initialization
  BalanceModel({
    required this.amount,
    required this.name,
    required this.price,
    required this.symbol,
    required this.type,
    required this.userID,
  });

  /// This method converts a balance model instance to a map
  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'name': name,
      'price': price,
      'symbol': symbol,
      'type': type,
      'userID': userID,
    };
  }

  /// This method converts a map to a balance model instance
  factory BalanceModel.fromMap(Map<String, dynamic> map) {
    return BalanceModel(
      amount: map['amount'] as String,
      name: map['name'] as String,
      price: map['price'] as String,
      symbol: map['symbol'] as String,
      type: map['type'] as String,
      userID: map['userID'] as String,
    );
  }
}

class BalanceModel {
  String amount;
  String name;
  String price;
  String symbol;
  String type;
  String userID;

  BalanceModel({
    required this.amount,
    required this.name,
    required this.price,
    required this.symbol,
    required this.type,
    required this.userID,
  });

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

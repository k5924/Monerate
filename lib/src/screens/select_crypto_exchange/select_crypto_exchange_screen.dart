import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';

/// This is the screen an end-user would see when selecting their cryptocurrency exchange
class SelectCryptoExchangeScreen extends StatefulWidget {
  /// This variable stores the named route of the select cryptocurrency exchange screen
  static const kID = 'select_crypto_exchange_screen';

  /// This is the constructor for this widget
  const SelectCryptoExchangeScreen({Key? key}) : super(key: key);

  @override
  _SelectCryptoExchangeScreenState createState() =>
      _SelectCryptoExchangeScreenState();
}

class _SelectCryptoExchangeScreenState
    extends State<SelectCryptoExchangeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Select Cryptocurrency Exchange"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: ListTile(
                title: const Text(
                  'Binance Exchange',
                ),
                subtitle: const Text(
                  "The worlds largest crypto exchange",
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProvideAPIKey(
                        exchangeName: 'binance',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';

/// This screen will be generated whenever a user clicks on a cryptocurrency exchange to add their balances from that exchange
class ProvideAPIKey extends StatefulWidget {
  /// This variable will store the name of the cryptocurrency exchange selected
  final String exchangeName;

  /// This is the constructor of this screen which will assign the name of the exchange to the exchangeName variable
  const ProvideAPIKey({Key? key, required this.exchangeName}) : super(key: key);

  @override
  _ProvideAPIKeyState createState() => _ProvideAPIKeyState();
}

class _ProvideAPIKeyState extends State<ProvideAPIKey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: ProvideAPIKeyForm(exchangeName: widget.exchangeName),
        ),
      ),
    );
  }
}

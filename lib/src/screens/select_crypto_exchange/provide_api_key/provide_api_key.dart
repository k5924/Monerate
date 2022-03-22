import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/providers/binance_exchange_provider.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';

class ProvideAPIKey extends StatefulWidget {
  final String exchangeName;
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

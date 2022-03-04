import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/providers/binance_exchange_provider.dart';
import 'package:monerate/src/utilities/export.dart';

class ProvideAPIKey extends StatefulWidget {
  final String exchangeName;
  const ProvideAPIKey({Key? key, required this.exchangeName}) : super(key: key);

  @override
  _ProvideAPIKeyState createState() => _ProvideAPIKeyState();
}

class _ProvideAPIKeyState extends State<ProvideAPIKey> {
  final TextEditingController apiKeyController = TextEditingController();
  final TextEditingController secretKeyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late BinanceExchangeProvider binanceExchangeProvider =
      BinanceExchangeProvider();

  @override
  void dispose() {
    apiKeyController.dispose();
    secretKeyController.dispose();
    super.dispose();
  }

  Future<void> connectToExchange() async {
    EasyLoading.show(status: 'loading...');
    if (widget.exchangeName == 'binance') {
      final result = await binanceExchangeProvider.getBalances(
        secretKeyController.text,
        apiKeyController.text,
      );
      if (result.runtimeType == String) {
        EasyLoading.showError(
          "An error was encountered, investments have not been fetched",
        );
      } else {
        print(result);
        EasyLoading.dismiss();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  const Text(
                    'Only enable read permissions for the API key, do not provide an API key with write conditions',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: apiKeyController,
                    validator: (value) {
                      if (Validator().presenceDetection(value) == false) {
                        return 'An API Key is required';
                      }
                    },
                    onSaved: (value) {
                      apiKeyController.text = value!;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter API Key',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: secretKeyController,
                    validator: (value) {
                      if (Validator().presenceDetection(value) == false) {
                        return 'A Secret Key is required';
                      }
                    },
                    onSaved: (value) {
                      secretKeyController.text = value!;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter Secret Key',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await connectToExchange();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      "Add Crypto Account",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

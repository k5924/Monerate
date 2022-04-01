import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';

/// This is the form that would be displayed for a user to enter their cryptocurrency exchanges secret and public API keys
class ProvideAPIKeyForm extends StatefulWidget {
  /// This variable will store the name of the cryptocurrency exchange
  final String exchangeName;

  /// This is the constructor of the APIKeyForm which will assign the exchangeName to the exchangeName variable
  const ProvideAPIKeyForm({Key? key, required this.exchangeName})
      : super(key: key);

  @override
  State<ProvideAPIKeyForm> createState() => _ProvideAPIKeyFormState();
}

class _ProvideAPIKeyFormState extends State<ProvideAPIKeyForm> {
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

  Future<bool?> _connectToExchange() async {
    EasyLoading.show(status: 'loading...');
    if (widget.exchangeName == 'binance') {
      final result = await binanceExchangeProvider.writeKeys(
        secret: secretKeyController.text,
        apiKey: apiKeyController.text,
      );
      if (result.runtimeType == String) {
        if (result == "error") {
          EasyLoading.showError(
            "An error was encountered, investments have not been fetched",
          );
        } else {
          EasyLoading.showError(result.toString());
        }
        return false;
      } else {
        EasyLoading.showSuccess("Cryptocurrency Exchange added to portfolio");
        return true;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
                return null;
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
                return null;
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
                  final opResult = await _connectToExchange();
                  if (opResult == true) {
                    // ignore: use_build_context_synchronously
                    Navigator.popUntil(
                      context,
                      ModalRoute.withName(EndUserDashboardScreen.kID),
                    );
                  }
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
    );
  }
}

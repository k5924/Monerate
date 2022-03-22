// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';

class ProvideInvestmentDetailsForm extends StatefulWidget {
  TickerModel investment;
  ProvideInvestmentDetailsForm({
    Key? key,
    required this.investment,
  }) : super(key: key);

  @override
  State<ProvideInvestmentDetailsForm> createState() =>
      _ProvideInvestmentDetailsFormState();
}

class _ProvideInvestmentDetailsFormState
    extends State<ProvideInvestmentDetailsForm> {
  final TextEditingController amountOwnedController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final YahooFinanceProvider yahooFinanceProvider = YahooFinanceProvider();
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);

  @override
  void dispose() {
    amountOwnedController.dispose();
    super.dispose();
  }

  Future<bool> _addInvestment() async {
    EasyLoading.show(status: 'loading...');
    final result =
        await yahooFinanceProvider.getPrice(widget.investment.symbol);
    if (result.toString() == "error") {
      EasyLoading.showError(
        "An error was encountered, investment information has not been fetched",
      );
      return false;
    } else {
      final result2 = await authProvider.addFinanceAccount(
        name: widget.investment.longName,
        symbol: widget.investment.symbol,
        type: "Stock",
        amount: amountOwnedController.text,
        price: result.toString(),
      );
      if (result2 != null) {
        EasyLoading.showError(result2);
        return false;
      } else {
        EasyLoading.showSuccess("Investment added to portfolio");
        return true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextFormField(
              controller: amountOwnedController,
              validator: AmountValidator().validateAmount,
              onSaved: (value) {
                amountOwnedController.text = value!;
              },
              decoration: const InputDecoration(
                hintText: 'Enter Amount Owned',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final opResult = await _addInvestment();
                  if (opResult == true) {
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
                "Add Investment",
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

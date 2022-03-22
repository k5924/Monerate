// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:monerate/src/models/balance_model.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';

class ViewInvestmentForm extends StatefulWidget {
  BalanceModel balance;
  ViewInvestmentForm({
    Key? key,
    required this.balance,
  }) : super(key: key);

  @override
  State<ViewInvestmentForm> createState() => _ViewInvestmentFormState();
}

class _ViewInvestmentFormState extends State<ViewInvestmentForm> {
  final TextEditingController amountOwnedController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final YahooFinanceProvider yahooFinanceProvider = YahooFinanceProvider();
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);

  Future<bool> _updateInvestment() async {
    EasyLoading.show(status: 'loading...');
    final result = await yahooFinanceProvider.getPrice(widget.balance.symbol);
    if (result.toString() == "error") {
      EasyLoading.showError(
        "An error was encountered, investment information has not been fetched",
      );
      return false;
    } else {
      final result2 = await authProvider.updateFinanceAccount(
        name: widget.balance.name,
        symbol: widget.balance.symbol,
        type: widget.balance.type,
        oldAmount: widget.balance.amount,
        oldPrice: widget.balance.price,
        userID: widget.balance.userID,
        newAmount: amountOwnedController.text,
        newPrice: result.toString(),
      );
      if (result2 != null) {
        EasyLoading.showError(result2);
        return false;
      } else {
        EasyLoading.showSuccess("Investment updated");
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
                  final opResult = await _updateInvestment();
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
                "Update Investment",
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

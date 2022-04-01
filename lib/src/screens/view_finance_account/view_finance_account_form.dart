// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';

/// This widget will display the form a user would fill out to update their account balance
class ViewFinanceAccountForm extends StatefulWidget {
  /// This will store a single account balance from an end-user
  BalanceModel balance;

  /// This constructor will assign the passed BalanceModel to the balance variable
  ViewFinanceAccountForm({
    Key? key,
    required this.balance,
  }) : super(key: key);

  @override
  State<ViewFinanceAccountForm> createState() => _ViewFinanceAccountFormState();
}

class _ViewFinanceAccountFormState extends State<ViewFinanceAccountForm> {
  final TextEditingController amountOwnedController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final YahooFinanceProvider yahooFinanceProvider = YahooFinanceProvider();
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);

  Future<bool> _updateAccount() async {
    EasyLoading.show(status: 'loading...');
    if (widget.balance.type == "Stock") {
      final result = await yahooFinanceProvider.getPrice(
        tickerSymbol: widget.balance.symbol,
      );
      if (result.toString() == "error") {
        EasyLoading.showError(
          "An error was encountered, investment information has not been fetched",
        );
        return false;
      } else {
        final result2 = await authProvider.updateFinanceAccount(
          balanceModel: widget.balance,
          newAmount: amountOwnedController.text,
          newPrice: result.toString(),
        );
        if (result2 != null) {
          EasyLoading.showError(result2);
          return false;
        } else {
          EasyLoading.showSuccess("Account updated");
          return true;
        }
      }
    } else {
      final result2 = await authProvider.updateFinanceAccount(
        balanceModel: widget.balance,
        newAmount: widget.balance.amount,
        newPrice: valueController.text,
      );
      if (result2 != null) {
        EasyLoading.showError(result2);
        return false;
      } else {
        EasyLoading.showSuccess("Account updated");
        return true;
      }
    }
  }

  @override
  void dispose() {
    amountOwnedController.dispose();
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            if (widget.balance.type == "Stock")
              TextFormField(
                controller: amountOwnedController,
                validator: AmountValidator().validateAmount,
                onSaved: (value) {
                  amountOwnedController.text = value!;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter Amount Owned',
                ),
              )
            else
              TextFormField(
                controller: valueController,
                validator: AmountValidator().validateAmount,
                onSaved: (value) {
                  valueController.text = value!;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter Current Value',
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final opResult = await _updateAccount();
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
                "Update Account",
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

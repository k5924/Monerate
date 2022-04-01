// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/widgets/export.dart';

class ViewFinanceAccountScreen extends StatefulWidget {
  BalanceModel balance;
  ViewFinanceAccountScreen({
    Key? key,
    required this.balance,
  }) : super(key: key);

  @override
  State<ViewFinanceAccountScreen> createState() =>
      _ViewFinanceAccountScreenState();
}

class _ViewFinanceAccountScreenState extends State<ViewFinanceAccountScreen> {
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);

  Widget updateStockAmount() {
    if ((widget.balance.type == "Stock") | (widget.balance.type == "Manual")) {
      return ViewFinanceAccountForm(
        balance: widget.balance,
      );
    } else {
      return Container();
    }
  }

  Future<String?> _removeAccount() {
    if ((widget.balance.type == "Stock") | (widget.balance.type == "Manual")) {
      return _displayConfirmationDialog(
        'Are you sure you want to delete this account balance?',
      );
    } else if (widget.balance.type == "Cryptocurrency") {
      return _displayConfirmationDialog(
        "Deleting this account will delete all Cryptocurrency accounts and they're API keys. Are you sure you want to delete this account balance?",
      );
    } else {
      return _displayConfirmationDialog(
        "Deleting this account will delete all Openbanking accounts and they're API keys. Are you sure you want to delete this account balance?",
      );
    }
  }

  void _closeDialogBox() {
    return Navigator.pop(context);
  }

  Future<String?> _displayConfirmationDialog(String content) {
    return customAlertDialog(
      context: context,
      title: "Confirm Delete Account",
      content: content,
      actions: [
        OutlinedButton(
          onPressed: () => _closeDialogBox(),
          child: const Text(
            "Cancel",
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            EasyLoading.show(status: 'loading...');
            if ((widget.balance.type == "Stock") |
                (widget.balance.type == "Manual")) {
              final result = await authProvider.removeFinanceAccount(
                balanceModel: widget.balance,
              );
              if (result != null) {
                _closeDialogBox();
                EasyLoading.showError(result);
              } else {
                Navigator.popAndPushNamed(
                  context,
                  EndUserDashboardScreen.kID,
                );
                EasyLoading.showSuccess("Account Deleted");
              }
            } else {
              final result = await authProvider.removeMultipleFinanceAccounts(
                balanceModel: widget.balance,
              );
              if (result != null) {
                _closeDialogBox();
                EasyLoading.showError(result);
              } else {
                Navigator.popAndPushNamed(
                  context,
                  EndUserDashboardScreen.kID,
                );
                EasyLoading.showSuccess("Accounts Deleted");
              }
            }
          },
          child: const Text("Delete Account"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CenteredScrollViewWithAppBar(
      appBarTitle: "Investment Details",
      floatingActionButton: null,
      children: [
        ListTile(
          title: Text(
            widget.balance.name,
          ),
          trailing: widget.balance.type == 'Cryptocurrency'
              ? Text(
                  'Holdings: ${widget.balance.amount}',
                )
              : Text(
                  "Price £${(double.parse(widget.balance.amount) * double.parse(widget.balance.price)).toStringAsFixed(2)}",
                ),
          subtitle: widget.balance.type == 'Stock'
              ? Text(
                  'Ticker: ${widget.balance.symbol} Type: ${widget.balance.type} Holdings: ${widget.balance.amount}',
                )
              : Text(
                  'Type: ${widget.balance.type}',
                ),
        ),
        const SizedBox(
          height: 20,
        ),
        updateStockAmount(),
        const SizedBox(
          height: 20,
        ),
        OutlinedButton.icon(
          onPressed: () async {
            await _removeAccount();
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
          ),
          icon: const Icon(Icons.delete_forever),
          label: const Text(
            "Remove Account",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ],
    );
  }
}

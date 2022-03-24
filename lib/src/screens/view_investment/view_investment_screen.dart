// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/auth_provider.dart';
import 'package:monerate/src/screens/export.dart';

class ViewInvestmentScreen extends StatefulWidget {
  BalanceModel balance;
  ViewInvestmentScreen({
    Key? key,
    required this.balance,
  }) : super(key: key);

  @override
  State<ViewInvestmentScreen> createState() => _ViewInvestmentScreenState();
}

class _ViewInvestmentScreenState extends State<ViewInvestmentScreen> {
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);

  Widget updateStockAmount() {
    if (widget.balance.type == "Stock") {
      return ViewInvestmentForm(
        balance: widget.balance,
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Investment Details"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
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
              OutlinedButton(
                onPressed: () async {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                ),
                child: const Text(
                  "Remove Account",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

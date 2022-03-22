// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:monerate/src/models/export.dart';
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
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Investment Details"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ViewInvestmentForm(balance: widget.balance,)
        ),
      ),
    );
  }
}
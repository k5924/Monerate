// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/screens/export.dart';

class ProvideInvestmentDetails extends StatefulWidget {
  TickerModel investment;
  ProvideInvestmentDetails({
    Key? key,
    required this.investment,
  }) : super(key: key);

  @override
  _ProvideInvestmentDetailsState createState() =>
      _ProvideInvestmentDetailsState();
}

class _ProvideInvestmentDetailsState extends State<ProvideInvestmentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Investment Details"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ProvideInvestmentDetailsForm(
            investment: widget.investment,
          ),
        ),
      ),
    );
  }
}

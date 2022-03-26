import 'package:flutter/material.dart';

class FinancialAdvisorHomepageTab extends StatefulWidget {
  const FinancialAdvisorHomepageTab({Key? key}) : super(key: key);

  @override
  State<FinancialAdvisorHomepageTab> createState() =>
      _FinancialAdvisorHomepageTabState();
}

class _FinancialAdvisorHomepageTabState extends State<FinancialAdvisorHomepageTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Financial Advisor HomePage",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

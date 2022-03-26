import 'package:flutter/material.dart';

class SupportManagerHomepageTab extends StatefulWidget {
  const SupportManagerHomepageTab({Key? key}) : super(key: key);

  @override
  State<SupportManagerHomepageTab> createState() =>
      _SupportManagerHomepageTabState();
}

class _SupportManagerHomepageTabState extends State<SupportManagerHomepageTab> {
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
                "Support Manager HomePage",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

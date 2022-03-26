import 'package:flutter/material.dart';

class EndUserHomepageTab extends StatefulWidget {
  const EndUserHomepageTab({Key? key}) : super(key: key);

  @override
  State<EndUserHomepageTab> createState() => _EndUserHomepageTabState();
}

class _EndUserHomepageTabState extends State<EndUserHomepageTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "End User HomePage",
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

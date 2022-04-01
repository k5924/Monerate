import 'package:flutter/material.dart';
import 'package:monerate/src/widgets/export.dart';

class EndUserHomepageTab extends StatefulWidget {
  const EndUserHomepageTab({Key? key}) : super(key: key);

  @override
  State<EndUserHomepageTab> createState() => _EndUserHomepageTabState();
}

class _EndUserHomepageTabState extends State<EndUserHomepageTab> {
  @override
  Widget build(BuildContext context) {
    return CenteredScrollView(
      children: [
        Text(
          "Transactions will display here",
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }
}

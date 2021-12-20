import 'package:flutter/material.dart';
import 'package:monerate/src/widgets/export.dart';

class ScreenHeader extends StatefulWidget {
  final String screenName;

  const ScreenHeader({Key? key, required this.screenName}) : super(key: key);

  @override
  _ScreenHeaderState createState() => _ScreenHeaderState();
}

class _ScreenHeaderState extends State<ScreenHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Monerate",
          style: Theme.of(context).textTheme.headline4,
        ),
        const AppIcon(),
        Text(
          widget.screenName,
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }
}

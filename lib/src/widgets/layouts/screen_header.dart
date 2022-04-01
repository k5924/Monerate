import 'package:flutter/material.dart';
import 'package:monerate/src/widgets/export.dart';

/// This is a custom layout widget which creates a header for a particular screen
class ScreenHeader extends StatefulWidget {
  /// This specifies the name of the screen which this widget will display as a String
  final String screenName;

  /// This constructor assigns the parameterized screenName String to a variable
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

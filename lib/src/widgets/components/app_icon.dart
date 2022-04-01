import 'package:flutter/material.dart';

/// This is a custom component to display the icon of the application
class AppIcon extends StatelessWidget {
  /// Tis is the constructor of the AppIcon component
  const AppIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.account_balance,
      size: 214,
    );
  }
}

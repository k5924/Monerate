import 'package:flutter/material.dart';

/// This is a custom layout widget which contains a scaffold, center, SingleChildScrollView, Padding and Column widget
class CenteredScrollView extends StatefulWidget {
  /// The children parameter stores a list of widgets to display on the screen
  final List<Widget> children;

  /// The constructor takes the widget list and assigns it to the children variable
  const CenteredScrollView({Key? key, required this.children})
      : super(key: key);

  @override
  _CenteredScrollViewState createState() => _CenteredScrollViewState();
}

class _CenteredScrollViewState extends State<CenteredScrollView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.children,
            ),
          ),
        ),
      ),
    );
  }
}

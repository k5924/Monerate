// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

/// This is a custom layout widget which has a scaffold, appbar, center, SingleChildScrollView, Padding, column and floating action button widget
class CenteredScrollViewWithAppBar extends StatefulWidget {
  /// This variable stores a list of widgets to display in the column widget
  List<Widget> children;

  /// This variable stores the title to be displayed in the app bar
  String appBarTitle;

  /// This variable stores either the floating action button widget or nothing
  FloatingActionButton? floatingActionButton;

  /// The constructor assigns each of the parameters to their respective variables
  CenteredScrollViewWithAppBar({
    Key? key,
    required this.children,
    required this.appBarTitle,
    required this.floatingActionButton,
  }) : super(key: key);

  @override
  State<CenteredScrollViewWithAppBar> createState() =>
      _CenteredScrollViewWithAppBarState();
}

class _CenteredScrollViewWithAppBarState
    extends State<CenteredScrollViewWithAppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.appBarTitle,
        ),
        centerTitle: true,
      ),
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
      floatingActionButton: widget.floatingActionButton,
    );
  }
}

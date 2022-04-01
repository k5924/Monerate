// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CenteredScrollViewWithAppBar extends StatefulWidget {
  List<Widget> children;
  String appBarTitle;
  FloatingActionButton? floatingActionButton;
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

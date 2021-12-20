import 'package:flutter/material.dart';

class CenteredScrollView extends StatefulWidget {
  final List<Widget> children;
  const CenteredScrollView({Key? key, required this.children}) : super(key: key);

  @override
  _CenteredScrollViewState createState() => _CenteredScrollViewState();
}

class _CenteredScrollViewState extends State<CenteredScrollView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.children,
          ),
        ),
      ),
    );
  }
}

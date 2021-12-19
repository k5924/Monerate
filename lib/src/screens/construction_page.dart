import 'package:flutter/material.dart';

class ConstructionPage extends StatefulWidget {
  static const String kID = 'construction_page';

  const ConstructionPage({Key? key}) : super(key: key);

  @override
  _ConstructionPageState createState() => _ConstructionPageState();
}

class _ConstructionPageState extends State<ConstructionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "This page is under construction",
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}

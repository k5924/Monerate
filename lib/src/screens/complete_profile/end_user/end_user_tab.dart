import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/widgets/export.dart';

class EndUserTab extends StatefulWidget {
  const EndUserTab({Key? key}) : super(key: key);

  @override
  _EndUserTabState createState() => _EndUserTabState();
}

class _EndUserTabState extends State<EndUserTab> {
  @override
  Widget build(BuildContext context) {
    return CenteredScrollView(
      children: [
        Text(
          "End-user",
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 25,
        ),
        Image.asset(
          'assets/images/End-user complete profile.png',
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          "I want to manage my finances",
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 25,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              CompleteEndUserProfile.kID,
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 10,
            ),
          ),
          child: const Text(
            "Complete Profile",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ],
    );
  }
}

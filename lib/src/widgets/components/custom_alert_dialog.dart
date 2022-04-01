import 'package:flutter/material.dart';

/// This is a custom widget to display a dialog box with custom titles, messages and dialog box actions
Future<String?> customAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  required List<Widget> actions,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: actions,
        )
      ],
    ),
  );
}

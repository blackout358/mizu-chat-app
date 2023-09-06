import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String dialogTitle;
  final String dialogText;
  final VoidCallback onPressed;
  const MyAlertDialog(
      {super.key,
      required this.dialogText,
      required this.onPressed,
      required this.dialogTitle});

  @override
  Widget build(BuildContext context) {
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text("Cancel"),
    );

    Widget confirmButton = TextButton(
      onPressed: () {
        onPressed();
        Navigator.of(context).pop();
      },
      child: const Text("Confirm"),
    );

    return AlertDialog(
      title: Text(dialogTitle),
      content: Text(dialogText),
      actions: [cancelButton, confirmButton],
    );
  }
}

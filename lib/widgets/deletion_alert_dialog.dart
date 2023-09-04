import 'package:flutter/material.dart';
import 'package:mizu/widgets/text_field.dart';
import 'package:mizu/widgets/text_field_validator.dart';

class MyDeletionDialog extends StatefulWidget {
  final String dialogTitle;
  final String dialogText;
  final VoidCallback onPressed;
  final TextEditingController confirmController;

  MyDeletionDialog({
    Key? key,
    required this.dialogText,
    required this.dialogTitle,
    required this.confirmController,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<MyDeletionDialog> createState() => _MyDeletionDialogState();
}

class _MyDeletionDialogState extends State<MyDeletionDialog> {
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    widget.confirmController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isValid = widget.confirmController.text == "CONFIRM";
    });
  }

  @override
  void dispose() {
    widget.confirmController.removeListener(_updateButtonState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text("Cancel"),
    );

    Widget confirmButton = TextButton(
      onPressed: isValid
          ? () {
              widget.onPressed();
              Navigator.popUntil(context, (route) => route.isFirst);
            }
          : null,
      child: Text("Confirm"),
    );

    Container typeBox = Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Are you sure you want to delete your account? Type "
            "CONFIRM"
            " to confirm",
          ),
          SizedBox(
            height: 15,
          ),
          MyDeletionTextField(
            controller: widget.confirmController,
            hintText: "",
          ),
        ],
      ),
    );

    return AlertDialog(
      title: Text(widget.dialogTitle),
      content: typeBox,
      actions: [cancelButton, confirmButton],
    );
  }
}

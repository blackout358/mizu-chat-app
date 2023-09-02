import 'package:flutter/material.dart';
import 'package:mizu/logic/auth/auth_service.dart';
import 'package:provider/provider.dart';

import '../logic/auth/error_code_handling.dart';
import '../widgets/snackbar.dart';
import '../widgets/text_field.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();
    final authService = Provider.of<AuthService>(context, listen: false);
    void updatePassword() async {
      try {
        await authService.updatePassword(messageController.text);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(
            text: ErrorCodeHandler.errorCodeDebug(e.toString()),
            textColour: Colors.black,
            height: 30,
            duration: 2,
            fontSize: 20,
            backgroundColor: Colors.purple[200]!,
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            "Hello WOrod",
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: MyTextField(
                  controller: messageController,
                  hintText: 'Enter message',
                  obscureText: false,
                ),
              ),
              IconButton(
                onPressed: updatePassword,

                // onPressed: () => print(widget.focusNode.hasFocus),
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                icon: const Icon(
                  Icons.send,
                  size: 40,
                  color: Color.fromRGBO(206, 147, 216, 1),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

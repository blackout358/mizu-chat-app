import 'package:flutter/material.dart';
import 'package:mizu/Screens/update_email_page.dart';
import 'package:mizu/Screens/update_password_page.dart';
import 'package:mizu/logic/auth/auth_service.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();
    final authService = Provider.of<AuthService>(context, listen: false);
    // void updatePassword() async {
    //   try {
    //     await authService.updatePassword(messageController.text);
    //   } catch (e) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       CustomSnackBar(
    //         text: ErrorCodeHandler.errorCodeDebug(e.toString()),
    //         textColour: Colors.black,
    //         height: 30,
    //         duration: 2,
    //         fontSize: 20,
    //         backgroundColor: Colors.purple[200]!,
    //       ),
    //     );
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateEmail(),
                  ),
                );
              },
              title: Text("Change email"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdatePassword(),
                  ),
                );
              },
              title: Text("Change password"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mizu/Screens/delete_account_page.dart';
import 'package:mizu/Screens/update_email_page.dart';
import 'package:mizu/Screens/update_password_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

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
          Spacer(),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeleteAccount(),
                  ),
                );
              },
              title: Text(
                "Delete account",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
